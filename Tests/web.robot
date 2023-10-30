*** Settings ***
Library   Browser
Suite Setup  Open Back Market

*** Variables ***
${MAIN_URL}  https://www.backmarket.co.uk/

*** Test Cases ***
Test Search
    Search For Product  iphone
    
*** Keywords ***
Open Back Market
    Set Browser Timeout  2m
    New Page  ${MAIN_URL}
    ${overlay_present} =  Run Keyword And Return Status    Get Element  xpath=//div[@data-testid='overlay']
    Run Keyword If    ${overlay_present}
    ...    Close Cookie Notification

Search For Product
    [Arguments]  ${product}
    ${search_xpath} =  Set Variable  //input[@id='forceQueryPersistanceID']
    Element Should Exist  ${search_xpath}
    Fill Text  xpath=${search_xpath}  ${product}
    ${search_button_xpath} =  Set Variable  //button[@aria-label='Search']
    Element Should Exist    ${search_button_xpath}
    Click  xpath=${search_button_xpath}
    

Close Cookie Notification
    ${no_cookies_link} =  Set Variable  //span[contains(text(), 'I refuse your cookies')]/..
    Element Should Exist    ${no_cookies_link}
    Click  xpath=${no_cookies_link}

Element Should Exist
    [Arguments]  ${xpath}
    ${element} =  Get Element  xpath=${xpath}
    Should Not Be Empty    ${element}


    
