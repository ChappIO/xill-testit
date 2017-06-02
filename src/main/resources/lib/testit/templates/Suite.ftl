<#--

    Copyright © 2017 Xillio (support@xillio.nl)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

-->
use System, Date, String, Assert;
include ${suite.robot} as testSuite;

argument suite;
var case = null;
suite.start = Date.now();

<#list suite.cases as case>

// Test Case: ${suite.robot}#${case.name}
do {
    System.print("Testing: ${suite.robot}#${case.name}");
    case = suite.cases[${case?index}];
    case.start = Date.now();
    
    <#if case.options.expectedError?has_content && case.options.expectedError?string != "false">
    <#-- This case expects an error -->
    do {
        testSuite->${case.name};
    } fail(e) { 
        <#if case.options.expectedError?string != "true">
        <#-- We require a specific error-->
        <#-- Here case.options.expectedError should not be rendered but concatenated on runtime instead to prevent escaping/injection issues --> 
        if(!String.matches(e.message, case.options.expectedError)) {
            Assert.error("Expected an error message matching '" :: case.options.expectedError :: "' but found '" :: e.message :: "'");
        }
        </#if>
    } success {
        Assert.error("Expected an error but the case ran without errors");
    }
    <#else>
    testSuite->${case.name};
    </#if>
} fail(e) {
    case.error = e;
} success {
    case.ok = true;
} finally {
    case.end = Date.now();
    case = null;
}

</#list>
