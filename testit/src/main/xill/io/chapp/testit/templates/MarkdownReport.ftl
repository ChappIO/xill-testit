<#--

    Copyright © 2017 Thomas Biesaart (thomas.biesaart@gmail.com)

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
# TestIT Test Report
${executionDate?datetime?string.medium}

## Summary

    Executed Tests:     ${executedTestCount}
    Successful Tests:   ${successfulTestCount}
    Failed Tests:       ${failedTestCount}

### Failed Tests

<#list suites.failed as suite>
#### Suite: ${suite.robot}

<#list suite.cases as case>
##### ${case.name}

Line ${case.error.line}
```
${case.error.message}
```
</#list>
</#list>

### Successful Tests

<#list suites.successful as suite>
#### Suite: ${suite.robot}

<#list suite.cases as case>
- ${case.name}
</#list>
</#list>