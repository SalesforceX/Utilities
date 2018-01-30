/**
 * @author - PankaJ Jakhar
 * @description - Utility class for SObjects and Schema related methods.
 **/
public with sharing class SFObjectUtil {
    private static final String CUSTOM_IDENTIFIER = '--';

    public class PicklistFieldInfo {
        public Map<String, String> picklistValuesMap { get; set; }
        public String defaultSelectOptionAPI { get; set; }
        public String defaultSelectOptionName { get; set; }

        public PicklistFieldInfo() {
            picklistValuesMap = new Map<String, String>();
        }
    }

    /**
     *
     *
     * @param includeStandard
     * @param includeCustom
     * @param includeManaged
     *
     * @return
     */
    public static Map<String, String> getOrgWideObjectsMap(Boolean includeStandard, Boolean includeCustom, Boolean includeManaged) {
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Map<String, String> objAPIToNameMap = new Map<String, String>();

        for (Schema.SObjectType objType : gd.values()) {
            Schema.DescribeSObjectResult dr = objType.getDescribe();

            // Include Managed Objects in the List.
            if (includeManaged && dr.isCustom() && (dr.getName().split(CUSTOM_IDENTIFIER).size() == 3)) {
                objAPIToNameMap.put(dr.getName(), dr.getLabel());
            }

            // Include Custom, Unmanaged Objects in List.
            if (includeCustom && dr.isCustom() && (dr.getName().split(CUSTOM_IDENTIFIER).size() != 3)) {
                objAPIToNameMap.put(dr.getName(), dr.getLabel());
            }

            // Include Standard Objects.
            if (includeStandard && !dr.isCustom()) {
                objAPIToNameMap.put(dr.getName(), dr.getLabel());
            }
        }
        System.debug('-----objAPIToNameMap-----:' + objAPIToNameMap);
        return objAPIToNameMap;
    }

    /**
     *
     *
     * @param objectAPI
     *
     * @return
     */
    public static Map<String, String> getFieldsMap(String objectAPI) {
        Schema.DescribeSObjectResult[] descResultsList = Schema.describeSObjects(
                new String[]{
                        objectAPI
                });
        Schema.DescribeSObjectResult descResult = descResultsList[0];
        Map<String, Schema.SObjectField> fieldsMap = descResult.fields.getMap();

        Map<String, String> fieldAPIToNameMap = new Map<String, String>();
        for (Schema.SObjectField field : fieldsMap.values()) {
            Schema.DescribeFieldResult dFieldResult = field.getDescribe();
            String fieldLabel = dFieldResult.getLabel();
            String fieldName = dFieldResult.getName();
            fieldAPIToNameMap.put(fieldName, fieldLabel);
        }
        return fieldAPIToNameMap;
    }

    /**
     * Get the fields of specific types only.
     *
     */
    public static Map<String, String> getFieldsMap(String objectAPI, Set<DisplayType> types) {
        Schema.DescribeSObjectResult[] descResultsList = Schema.describeSObjects(
                new String[]{
                        objectAPI
                });
        Schema.DescribeSObjectResult descResult = descResultsList[0];
        Map<String, Schema.SObjectField> fieldsMap = descResult.fields.getMap();

        Map<String, String> fieldAPIToNameMap = new Map<String, String>();
        for (Schema.SObjectField field : fieldsMap.values()) {
            Schema.DescribeFieldResult dFieldResult = field.getDescribe();
            if (!types.contains(dFieldResult.getType())) continue;

            String fieldLabel = dFieldResult.getLabel();
            String fieldName = dFieldResult.getName();
            fieldAPIToNameMap.put(fieldName, fieldLabel);
        }
        return fieldAPIToNameMap;
    }

    /**
     *
     *
     * @param objectAPI
     *
     * @return
     */
    public static String getObjectName(String objectAPI) {
        Schema.DescribeSObjectResult[] descResultsList = Schema.describeSObjects(
                new String[]{
                        objectAPI
                });
        Schema.DescribeSObjectResult descResult = descResultsList[0];
        return descResult.getLabel();
    }

    /**
     *
     *
     * @param childObjectAPI
     * @param parentObjectAPI
     *
     * @return
     */
    public static Map<String, String> getLookupNamesMap(String childObjectAPI, String parentObjectAPI) {
        Schema.DescribeSObjectResult[] descResultsList = Schema.describeSObjects(
                new String[]{
                        childObjectAPI
                });
        Schema.DescribeSObjectResult descResult = descResultsList[0];
        Map<String, Schema.SObjectField> fieldsMap = descResult.fields.getMap();

        Map<String, String> fieldAPIToNameMap = new Map<String, String>();
        for (Schema.SObjectField field : fieldsMap.values()) {
            Schema.DescribeFieldResult dFieldResult = field.getDescribe();
            System.debug('-----dFieldResult-----:' + dFieldResult);
            String fieldLabel = dFieldResult.getLabel();
            String fieldName = dFieldResult.getLocalName();
            if (fieldName.equalsIgnoreCase(parentObjectAPI)) fieldAPIToNameMap.put(fieldName, fieldLabel);
        }
        return fieldAPIToNameMap;
    }

    /**
     *
     * @param objectAPI
     * @param fieldAPI
     * @param includeAll
     *
     * @return
     */
    public static PicklistFieldInfo getPicklistFieldInfo(String objectAPI, String fieldAPI, Boolean includeAll) {
        PicklistFieldInfo picklistInfo = new PicklistFieldInfo();

        Schema.DescribeSObjectResult[] descResultsList = Schema.describeSObjects(
                new String[]{
                        objectAPI
                });
        Schema.DescribeSObjectResult descResult = descResultsList[0];
        Schema.SObjectField field = descResult.fields.getMap().get(fieldAPI);
        Schema.DescribeFieldResult dFieldResult = field.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = dFieldResult.getPicklistValues();

        Map<String, String> picklistValuesMap = new Map<String, String>();
        for (Schema.PicklistEntry picklistEntry : picklistEntries) {
            // Include only if value is Active.
            if (includeAll) picklistValuesMap.put(picklistEntry.getValue(), picklistEntry.getLabel()); else if (picklistEntry.isActive()) picklistValuesMap.put(picklistEntry.getValue(), picklistEntry.getLabel());

            if (picklistEntry.isDefaultValue()) {
                picklistInfo.defaultSelectOptionAPI = picklistEntry.getValue();
                picklistInfo.defaultSelectOptionName = picklistEntry.getLabel();
            }
        }
        picklistInfo.picklistValuesMap = picklistValuesMap;
        return picklistInfo;
    }

    /**
     *
     * @param objectAPI
     * @param fieldAPI
     *
     * @return
     */
    public static PicklistFieldInfo getPicklistFieldInfo(String objectAPI, String fieldAPI) {
        return getPicklistFieldInfo(objectAPI, fieldAPI, true);
    }

    /**
     *
     * @param objectAPI
     * @param fieldAPI
     * @param includeAll
     *
     * @return
     */
    public static Map<String, String> getPicklistValuesMap(String objectAPI, String fieldAPI, Boolean includeAll) {
        Schema.DescribeSObjectResult[] descResultsList = Schema.describeSObjects(
                new String[]{
                        objectAPI
                });
        Schema.DescribeSObjectResult descResult = descResultsList[0];
        Schema.SObjectField field = descResult.fields.getMap().get(fieldAPI);
        Schema.DescribeFieldResult dFieldResult = field.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = dFieldResult.getPicklistValues();

        Map<String, String> picklistValuesMap = new Map<String, String>();
        for (Schema.PicklistEntry picklistEntry : picklistEntries) {
            // Include only if value is Active.
            if (includeAll) picklistValuesMap.put(picklistEntry.getValue(), picklistEntry.getLabel()); else if (picklistEntry.isActive()) picklistValuesMap.put(picklistEntry.getValue(), picklistEntry.getLabel());
        }
        return picklistValuesMap;
    }

    /**
     *
     * @param objectAPI
     * @param fieldAPI
     *
     * @return
     */
    public static Map<String, String> getPicklistValuesMap(String objectAPI, String fieldAPI) {
        return getPicklistValuesMap(objectAPI, fieldAPI, true);
    }

    public static List<String> getPicklistValues(String objectAPI, String fieldAPI, Boolean includeAll) {
        Schema.DescribeSObjectResult[] descResultsList = Schema.describeSObjects(
                new String[]{
                        objectAPI
                });
        Schema.DescribeSObjectResult descResult = descResultsList[0];
        Schema.SObjectField field = descResult.fields.getMap().get(fieldAPI);
        Schema.DescribeFieldResult dFieldResult = field.getDescribe();
        List<Schema.PicklistEntry> picklistEntries = dFieldResult.getPicklistValues();

        List<String> picklistValues = new List<String>();
        for (Schema.PicklistEntry picklistEntry : picklistEntries) {
            // Include only if value is Active.
            if (includeAll) picklistValues.add(picklistEntry.getLabel()); else if (picklistEntry.isActive()) picklistValues.add(picklistEntry.getLabel());
        }
        return picklistValues;
    }

    public static List<String> getPicklistValues(String objectAPI, String fieldAPI) {
        return getPicklistValues(objectAPI, fieldAPI, true);
    }

    /**
     *
     *
     * @param SObject Name for which related list Map is to be returned.
     *
     * @return Returns the Map of SObject's API to Name for an Object.
     */
    public static Map<String, String> getRelatedObjectsList(String objectAPI) {
        System.debug('-----getRelatedObjectsList-----:' + objectAPI);
        Map<String, String> objectAPIToNameMap = new Map<String, String>();

        Schema.DescribeSObjectResult[] descResultsList = Schema.describeSObjects(
                new String[]{
                        objectAPI
                });
        Schema.DescribeSObjectResult describeResult = descResultsList[0];
        List<Schema.ChildRelationship> childRelationshipsList = describeResult.getChildRelationships();
        for (Schema.ChildRelationship childRelationship : childRelationshipsList) {
            Schema.DescribeSObjectResult describeSObjectResult = childRelationship.getChildSObject().getDescribe();
            objectAPIToNameMap.put(describeSObjectResult.getName(),
                    describeSObjectResult.getLabel());
        }

        return objectAPIToNameMap;
    }
}