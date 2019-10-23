import React from 'react';
import PetAdmin from "./pet-admin";
import AuthProvider from "@xilution/xilution-iam-react";

const App = () => (
    <AuthProvider
        env={"test"}
        organizationId={"8dc3095110334e67a8c37d94c14935f5"}
        clientId={"d5b322f4b71c47ad82533e8813cfaa3a"}
        scope={"read"}
    >
        <PetAdmin/>
    </AuthProvider>
);

export default App;
