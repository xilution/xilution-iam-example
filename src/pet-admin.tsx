import React, {Component} from 'react';
import buildGraphQLProvider from 'ra-data-graphql';
import {Admin, Resource, Delete} from 'react-admin';
import {injectAuth} from "@xilution/xilution-iam-react";
import gql from 'graphql-tag';

interface IProps {
}

interface IState {
    dataProvider: any,
}

const buildFieldList = (introspectionResults: any, resource: any, raFetchType: any) => {

};

const buildQuery = (introspectionResults: any) => (raFetchType: any, resourceName: any, params: any) => {
    const resource = introspectionResults.resource.find((r: any) => r.type.name === resourceName);

    switch (raFetchType) {
        case 'GET_ONE':
            return {
                query: gql`query ${resource[raFetchType].name}($id: ID) {
                data: ${resource[raFetchType].name}(id: $id) {
                ${buildFieldList(introspectionResults, resource, raFetchType)}
                }
                }`,
                variables: params, // params = { id: ... }
                parseResponse: (response: any) => response.data,
            }
    // break;
    // ... other types handled here
    }
};

class PetAdmin extends Component<IProps, IState> {
    constructor(props: IProps) {
        super(props);
        this.state = {dataProvider: null};
    }

    componentDidMount() {
        buildGraphQLProvider({buildQuery})
            .then((dataProvider: any) => this.setState({dataProvider}));
    }

    render() {
        const {dataProvider} = this.state;

        if (!dataProvider) {
            return <div>Loading</div>;
        }

        return (
            <Admin dataProvider={dataProvider}>
                <Resource name="pets"/>
            </Admin>
        );
    }
}

export default injectAuth(PetAdmin);
