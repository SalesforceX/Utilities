## Utilities
> Salesforce Utilities for Rapid Development

## Features

### Get Org-wide SObjects Map<String, String>; SObject Name to its API Map.
```java
public static Map<String, String> getOrgWideObjectsMap(Boolean includeStandard, Boolean includeCustom, Boolean includeManaged) {...}
```
1. includeStandard: pass this parameter as true to get all the **Standard Objects** returned.
2. includeCustom: pass this parameter as true to get all the **Custom Objects** returned.
3. includeManaged: pass this parameter as true to get all the **Managed Objects** returned.


* Get fields Map<String, String>; Field Name to it's API Map.
```java
public static Map<String, String> getFieldsMap(String objectAPI) {...}
```
This will return you all the fields for a SObject with its API Names and Labels.


* Get fields Map<String, String>; Field Name to it's API Map, given a filter of DisplayTypes to it.
```java
public static Map<String, String> getFieldsMap(String objectAPI, Set<DisplayType> types) {...}
```
In this method, pass DisplayType's Set to filter the results. This will give you only the Map of fields for desired Data/DisplayType.

* Pass SObject API and get the Label.
```java
public static String getObjectName(String objectAPI) {...}
```
Simplest one. Pass the SObject API and get its Label/Name returned.

## Extras
* Get all the Lookup Field names of an Object on its Child Object.
```java
public static Map<String, String> getLookupNamesMap(String childObjectAPI, String parentObjectAPI) {...}
```
In this method, pass the child SObject API and parent SObject API and this will return all the Lookup fields on Child for respective parent SObject.

* Get all the Picklist Field Options with their API and Name wrapped in a wrapper class.
```java
public static PicklistFieldInfo getPicklistFieldInfo(String objectAPI, String fieldAPI, Boolean includeAll) {...}
```
This method will return a Picklist field's values' API and corresponding Label wrapped in PicklistFieldInfo class.

* Get all the child relationships of a SObject.
```java
public static Map<String, String> getRelatedObjectsList(String objectAPI) {...}
```
In this method, pass the SObject API and it will return all the Child Relationship for the SObject.