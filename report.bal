import ballerina/time;
import ballerina/io;

type TimeRecord record {
    string startTime;
    string endTime;
};

type Report record {
    TimeRecord jvm_service;
    TimeRecord graalvm_service;
    TimeRecord go_service;
    TimeRecord flask_service;
};

type Guest record {
    Address address?;
};
type Address record {
    Street street?;
    string city;
    string country;
};

type Street record {
    string name?;
    int number;
};


public function main() returns time:Error? {
    Report report = check (check io:fileReadJson("results.json")).cloneWithType();
    io:println("JVM Service: ", calcluateDiff(report.jvm_service));
    io:println("GraalVM Service: ", calcluateDiff(report.graalvm_service));
    io:println("Go Service: ", calcluateDiff(report.go_service));
    io:println("Flask Service: ", calcluateDiff(report.flask_service));

}

function calcluateDiff(TimeRecord timeRecord) returns time:Seconds|error {
    time:Utc startTimeUTC = check time:utcFromString(timeRecord.startTime);
    time:Utc endTimeUTC = check time:utcFromString(timeRecord.endTime);
    time:Seconds utcDiffSeconds = time:utcDiffSeconds(endTimeUTC, startTimeUTC);
    return utcDiffSeconds;
}
