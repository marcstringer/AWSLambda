# Test Instructions

The instructions will show you how to set up the tests for AWS Lambda.


## Setting up a Lambda

1. Go to the AWS Lambda console.
1. “Create a Lambda function”
1. “Select blueprint” – “Blank function”
1. “Configure function”:
    1. Give function a name myReceive
    1. Select runtime “Node.js 4.3”
    1. Paste in code from *myReceive.js*
    1. Leave “Handler” as default (“index.handler”)
    1. Set “Role” to “Create new role from template(s)”
    1. Set “Role name” to “role_with_no_permissions”
    1. Leave “Policy templates” empty
    1. “Next”
1. “Create function”
1. "You will need to create several functions that are required for all the tests. Only steps that are changed are 4.1 and 4.3 which are based on the *.js* name e.g you need to create a function called *mySend* in 4.1 in step 4.3 you would copy from *mySend.js*
1. Please Ensure that you enter your aws keys at the top of the agent.test.nut



The AWSLambda library is licensed under the [MIT License](../LICENSE).
