*** Settings ***
Library   Browser
Suite Setup  Open Back Market

*** Variables ***
${MAIN_URL}  https://www.backmarket.co.uk/

*** Test Cases ***
Test Search
    Search For Product  iphone 12

Test Cart
    Add Item To Cart    64 GB - Black - Unlocked
    Verify Item Added To Cart  iPhone 12 64GB - Black - Unlocked

Test Damage Coverage
    Add Damage Coverage    12-month Damage Cover
    Verify Damage Coverage  12-month Damage Cover
    
*** Keywords ***
Open Back Market
    Set Browser Timeout  2m
    New Page  ${MAIN_URL}
    ${overlay_present} =  Run Keyword And Return Status    Get Element  xpath=//div[@data-testid='overlay']
    Run Keyword If    ${overlay_present}
    ...    Close Cookie Notification

Add Damage Coverage
    [Arguments]  ${coverage_text}
    ${damage_coverage_xpath} =  Set Variable  //span[contains(text(), '${coverage_text}')]
    Element Should Exist    ${damage_coverage_xpath}
    Click  xpath=${damage_coverage_xpath}
    
Verify Damage Coverage
    [Arguments]  ${coverage_text}
    ${damage_coverage_xpath} =  Set Variable  //span[contains(text(), '${coverage_text}')]
    ${damage_coverage_radio_xpath} =  Set Variable  ${damage_coverage_xpath}/../../../../../input[@type='radio']
    Element Should Exist    ${damage_coverage_radio_xpath}
    Get Element States  xpath=${damage_coverage_radio_xpath}  contains  checked

Add Item To Cart
    [Arguments]  ${specs}
    ${first_element_xpath} =  Set Variable  (//span[contains(text(), '${specs}')])[1]
    Element Should Exist    ${first_element_xpath}
    Click  xpath=${first_element_xpath}
    ${buy_button_xpath} =  Set Variable  //button[@data-id='product-page-buy-button-desktop']
    Element Should Exist    ${buy_button_xpath}
    Click  xpath=${buy_button_xpath}
    ${offer_present} =  Run Keyword And Return Status    Get Element  xpath=//span[@id='modalTitle']
    Run Keyword If  ${offer_present}
    ...    Close Offer Notification

Close Offer Notification
    ${no_button} =  Set Variable  //button[@data-test='user-no']
    Element Should Exist    ${no_button}
    Click  xpath=${no_button}

Verify Item Added To Cart
    [Arguments]  ${item_name}
    ${verification_message} =  Set Variable  //h3[contains(text(), 'was added to cart')]
    Element Should Exist    ${verification_message}
    ${go_to_cart_xpath} =  Set Variable  //button[@data-qa='continue-shopping']
    Element Should Exist    ${go_to_cart_xpath}
    Click  xpath=${go_to_cart_xpath}
    ${cart_label_xpath} =  Set Variable  //h1[contains(text(), 'Your cart')]
    Element Should Exist    ${cart_label_xpath}
    ${cart_item_xpath} =  Set Variable  //div[contains(text(), '${item_name}')]


Search For Product
    [Arguments]  ${product}
    ${search_xpath} =  Set Variable  //input[@id='forceQueryPersistanceID']
    Element Should Exist  ${search_xpath}
    Fill Text  xpath=${search_xpath}  ${product}
    ${search_button_xpath} =  Set Variable  //button[@aria-label='Search']
    Element Should Exist    ${search_button_xpath}
    Click  xpath=${search_button_xpath}
    ${search_result_text} =  Set Variable  //span[contains(text(), 'iphone 12')]
    Element Should Exist    ${search_result_text}
    

Close Cookie Notification
    ${no_cookies_link} =  Set Variable  //span[contains(text(), 'I refuse your cookies')]/..
    Element Should Exist    ${no_cookies_link}
    Click  xpath=${no_cookies_link}

Element Should Exist
    [Arguments]  ${xpath}
    ${element} =  Get Element  xpath=${xpath}
    Should Not Be Empty    ${element}


    
