import {injectAuth} from "@xilution/xilution-iam-react";
import {InMemoryCache} from "apollo-cache-inmemory";
import {ApolloClient} from "apollo-client";
import {createHttpLink} from "apollo-link-http";
import gql from "graphql-tag";
import buildGraphQLProvider from "ra-data-graphql";
import * as React from "react";
import {
    Admin,
    Create,
    Datagrid,
    DateField,
    Edit,
    List,
    Resource,
    Show,
    SimpleForm,
    SimpleShowLayout,
    TextField,
    TextInput,
} from "react-admin";

interface IProps {
    env: string;
    apiBaseUrl: string;
}

interface IState {
    dataProvider: any;
}

const buildQuery = (introspectionResults: any) => (raFetchType: string, resourceName: string, params: any) => {
    switch (raFetchType) {
        case "GET_LIST":
            return {
                parseResponse: (response: any) => response.data.pets,
                query: gql(
                    `query ListPets($sort: String, $query: String, $pageNumber: Int, $pageSize: Int) {
                      pets(sort: $sort, query: $query, pageNumber: $pageNumber, pageSize: $pageSize) {
                        data: content {
                          name
                          id
                          createdAt
                          owningUserId
                        }
                        total: totalElements
                      }
                    }`,
                ),
                variables: {
                    pageNumber: params.pagination.page - 1,
                    pageSize: params.pagination.perPage,
                },
            };
        case "GET_ONE":
            return {
                parseResponse: (response: any) => response.data,
                query: gql(
                    `query GetOnePet($id: String!) {
                      data: pet(id: $id) {
                        name
                        id
                        createdAt
                        owningUserId
                      }
                    }`),
                variables: params,
            };
        case "DELETE":
            return {
                parseResponse: (response: any) => ({data: response.data.deletePet}),
                query: gql(
                    `mutation DeletePet($id: String!) {
                      deletePet(id: $id) {
                          id
                          name
                          createdAt
                          owningUserId
                      }
                    }`,
                ),
                variables: params,
            };
        case "CREATE":
            return {
                parseResponse: (response: any) => ({data: response.data.createPet}),
                query: gql(
                    `mutation CreatePet($newPet: NewPet!) {
                      createPet(pet: $newPet) {
                          id
                          name
                          createdAt
                          owningUserId
                      }
                    }`,
                ),
                variables: {
                    newPet: {
                        name: params.data.name,
                        owningUserId: params.data.owningUserId,
                    },
                },
            };
        case "UPDATE":
            return {
                parseResponse: (response: any) => ({data: response.data.updatePet}),
                query: gql(
                    `mutation UpdatePet($id: String! $updatedPet: UpdatedPet!) {
                      updatePet(id: $id pet: $updatedPet) {
                          id
                          name
                          createdAt
                          owningUserId
                      }
                    }`,
                ),
                variables: {
                    id: params.id,
                    updatedPet: {
                        name: params.data.name,
                    },
                },
            };
        default:
            throw new Error(`Unknown: ${raFetchType}`);
    }
};

const PetList = (props: any) => (
    <List {...props}>
        <Datagrid rowClick="edit">
            <TextField source="id"/>
            <TextField source="name"/>
            <TextField source="owningUserId"/>
            <DateField source="createdAt"/>
        </Datagrid>
    </List>
);

const PetShow = (props: any) => (
    <Show {...props}>
        <SimpleShowLayout>
            <TextField source="id"/>
            <TextField source="name"/>
            <TextField source="owningUserId"/>
            <DateField source="createdAt"/>
        </SimpleShowLayout>
    </Show>
);

const PetCreate = (props: any) => (
    <Create {...props}>
        <SimpleForm>
            <TextInput source="name"/>
            <TextInput source="owningUserId"/>
        </SimpleForm>
    </Create>
);

const PetUpdate = (props: any) => (
    <Edit {...props}>
        <SimpleForm>
            <TextField source="id"/>
            <TextInput source="name"/>
            <TextInput source="owningUserId"/>
        </SimpleForm>
    </Edit>
);

class PetAdmin extends React.Component<IProps, IState> {
    constructor(props: IProps) {
        super(props);
        this.state = {dataProvider: null};
    }

    public componentDidMount() {
        const {env, apiBaseUrl} = this.props;

        buildGraphQLProvider({
            buildQuery,
            client: new ApolloClient({
                cache: new InMemoryCache(),
                link: createHttpLink({
                    uri: `${apiBaseUrl}/graphql`,
                }),
            }),
        }).then((dataProvider: any) => this.setState({dataProvider}));
    }

    public render() {
        const {dataProvider} = this.state;

        if (!dataProvider) {
            return <div>Loading</div>;
        }

        return (
            <Admin dataProvider={dataProvider}>
                <Resource
                    name="Pets"
                    list={PetList}
                    show={PetShow}
                    create={PetCreate}
                    edit={PetUpdate}
                />
            </Admin>
        );
    }
}

export default injectAuth(PetAdmin);
