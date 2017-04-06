
// Enter your AWS keys here
const AWS_LAMBDA_REGION = "us-west-1"
const ACCESS_KEY_ID     = "YOUR_ACCES_KEY_ID";
const SECRET_ACCESS_KEY = "YOUR_SECRET_ACCESS_KEY";

// contants for the testReceive function
const TEST_RECEIVE_LAMBDA_FUNCTION = "hellowWorld";
const TEST_RECEIVE_RETURNED_STRING = "Hello from Lambda"; // chaning this requires the lambda code to be changed
const TEST_RECEIVE_SENT_MESSAGE = "hello world!";

// constants for the testSendReceive function
const TEST_SEND_LAMBDA_FUNCTION = "mySend";
const TEST_SEND_MESSAGE = "Hello Hello!";

class AgentTestCase extends ImpTestCase {

    function setUp() {
        server.log("Started testing...")
    }

    // tests that the lambda library is capable of receiving a payload from aws
    function testReceive() {
        local lambda = AWSLambda(AWS_LAMBDA_REGION, ACCESS_KEY_ID, SECRET_ACCESS_KEY);
        local body = { "transmit": TEST_RECEIVE_SENT_MESSAGE };
        local params = {
            "payload": body,
            "functionName": TEST_RECEIVE_LAMBDA_FUNCTION
        }
        return Promise(function(resolve, reject) {
            lambda.invoke(params, function(result) {
                local payload = http.jsondecode(result.body);
                if ("errorMessage" in payload) {
                    return reject("error in payload");
                } else {
                    try {
                        this.assertTrue(payload == TEST_RECEIVE_RETURNED_STRING, "the payload is" + payload);
                        resolve();
                    } catch (e) {
                        return reject(e);
                    }

                }
            }.bindenv(this));
        }.bindenv(this));
    }
    // test that the lambda library is capable of sending a payload from aws
    function testSendReceive() {
        local lambda = AWSLambda(AWS_LAMBDA_REGION, ACCESS_KEY_ID, SECRET_ACCESS_KEY);
        local body = { "transmit": TEST_SEND_MESSAGE };
        local params = {
            "payload": body,
            "functionName": TEST_SEND_LAMBDA_FUNCTION
        }
        return Promise(function(resolve, reject) {
            lambda.invoke(params, function(result) {
                local payload = http.jsondecode(result.body);
                server.log(payload.transmit);
                if ("errorMessage" in payload) {
                    return reject("error in payload " + payload.errorMessage);
                }
                else {
                    try {
                        this.assertTrue(payload.transmit == TEST_SEND_MESSAGE, "the payload is" + payload);
                        resolve();
                    }
                    catch (e) {
                        return reject(e);
                    }
                }
            }.bindenv(this));
        }.bindenv(this));
    }

}
