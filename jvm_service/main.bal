import ballerina/http;
import ballerina/lang.runtime;
import ballerina/log;

service class SimpleService {
    *http:Service;

    resource function get foo() returns string {
        return "Hello, World!";
    }
}


configurable int simpleServicePort = 8080;

public function main() returns error? {
    http:Listener conferenceListener = check new (simpleServicePort, timeout = 0);
    log:printInfo("Starting the listener...");
    // Attach the service to the listener.
    check conferenceListener.attach(new SimpleService());
    // Start the listener.
    check conferenceListener.'start();
    // Register the listener dynamically.
    runtime:registerListener(conferenceListener);
    log:printInfo(string `Startup completed. Listening on: http://localhost:${simpleServicePort}`);
}
