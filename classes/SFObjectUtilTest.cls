/**
 * @author - Master
 * @description - Test class for SFObjectUtil.
 * 
 **/
@isTest(SeeAllData = false)
public class SFObjectUtilTest {

    @isTest
    private static void test_getOrgWideObjectsList_IncludeAllObjects() {
        SFObjectUtil.getOrgWideObjectsMap(true, true, true);
    }
    
    @isTest
    private static void test_getFieldsMap_GetAllFieldsName() {
        String objectName = 'Account';
        Map<String, String> getFieldsMap = SFObjectUtil.getFieldsMap(objectName);
        System.debug('-----getFieldsMap-----:' + getFieldsMap);
        System.assert(getFieldsMap.size() > 0);
    }
    
    @isTest
    private static void test_getPicklistValues_FetchForAccountField() {
        String objectName = 'Account';
        String fieldName = 'Type';
        List<String> picklistValues = SFObjectUtil.getPicklistValues(objectName, fieldName);
        System.debug('-----picklistValues-----:' + picklistValues);
        System.assert(picklistValues.size() > 0);
    }
    
    @isTest
    private static void test_getPicklistValuesMap_FetchForAccountField() {
        String objectName = 'Account';
        String fieldName = 'Type';
        Map<String, String> picklistValuesMap = SFObjectUtil.getPicklistValuesMap(objectName, fieldName);
        System.debug('-----picklistValuesMap-----:' + picklistValuesMap);
        System.assert(picklistValuesMap.size() > 0);
    }
    
    @isTest
    private static void test_getPicklistFieldInfo_FetchForAccountField() {
        String objectName = 'Account';
        String fieldName = 'Type';
        SFObjectUtil.PicklistFieldInfo picklistInfo = SFObjectUtil.getPicklistFieldInfo(objectName, fieldName);
        System.debug('-----picklistInfo-----:' + picklistInfo);
        System.assert(picklistInfo.picklistValuesMap.size() > 0);
    }

    @isTest
    private static void test_getRelatedObjectsList() {
        String objectAPI = 'Rule__c';
        Map<String, String> objectAPIToNameMap = SFObjectUtil.getRelatedObjectsList(objectAPI);
        System.debug('-----objectAPIToNameMap-----:' + objectAPIToNameMap);
        System.assert(objectAPIToNameMap.size() > 0);
    }

    @isTest
    private static void test_getLookupNamesMap() {
        String parentObjectAPI = 'Rule__c';
        String childObjectAPI = 'Action__c';
        Map<String, String> fieldAPIToNameMap = SFObjectUtil.getLookupNamesMap(childObjectAPI, parentObjectAPI);
        System.debug('-----fieldAPIToNameMap-----:' + fieldAPIToNameMap);
        System.assert(fieldAPIToNameMap.size() > 0);
    }
}