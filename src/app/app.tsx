import AuthProvider from "@xilution/xilution-iam-react";
import * as React from "react";
import PetAdmin from "../components/pet-admin";

// @ts-ignore
const XILUTION_ENVIRONMENT = __XILUTION_ENVIRONMENT__;
// @ts-ignore
const XILUTION_SUB_ORGANIZATION_ID = __XILUTION_SUB_ORGANIZATION_ID__;
// @ts-ignore
const XILUTION_WEB_CLIENT_ID = __XILUTION_WEB_CLIENT_ID__;
// @ts-ignore
const API_BASE_URL = __API_BASE_URL__;
const SCOPE = "read write";

const App = () => (
    <AuthProvider
        env={XILUTION_ENVIRONMENT}
        organizationId={XILUTION_SUB_ORGANIZATION_ID}
        clientId={XILUTION_WEB_CLIENT_ID}
        scope={SCOPE}
    >
        <PetAdmin
            env={XILUTION_ENVIRONMENT}
            apiBaseUrl={API_BASE_URL}
        />
    </AuthProvider>
);

export default App;
