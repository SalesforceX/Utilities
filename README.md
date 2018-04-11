### Utilities
> Salesforce Utilities for Rapid Development

### Features

1. Get Org-wide SObjects Map<String, String>; SObject Name to its API Map.
	```java
	public static Map<String, String> getOrgWideObjectsMap(Boolean includeStandard, Boolean includeCustom, Boolean includeManaged) {...}
	```
	* _includeStandard_: pass this parameter as true to get all the **Standard Objects** returned.
	* _includeCustom_: pass this parameter as true to get all the **Custom Objects** returned.
	* _includeManaged_: pass this parameter as true to get all the **Managed Objects** returned.


2. Get fields Map<String, String>; Field Name to it's API Map.
	```java
	public static Map<String, String> getFieldsMap(String objectAPI) {...}
	```
	This will return you all the fields for a SObject with its API Names and Labels.

3. Get fields Map<String, String>; Field Name to it's API Map, given a filter of DisplayTypes to it.
	```java
	public static Map<String, String> getFieldsMap(String objectAPI, Set<DisplayType> types) {...}
	```
	In this method, pass DisplayType's Set to filter the results. This will give you only the Map of fields for desired Data/DisplayType.

4. Pass SObject API and get the Label.
	```java
	public static String getObjectName(String objectAPI) {...}
	```
	Simplest one. Pass the SObject API and get its Label/Name returned.

### Extras
1. Get all the Lookup Field names of an Object on its Child Object.
	```java
	public static Map<String, String> getLookupNamesMap(String childObjectAPI, String parentObjectAPI) {...}
	```
	In this method, pass the child SObject API and parent SObject API and this will return all the Lookup fields on Child for respective parent SObject.

2. Get all the Picklist Field Options with their API and Name wrapped in a wrapper class.
	```java
	public static PicklistFieldInfo getPicklistFieldInfo(String objectAPI, String fieldAPI, Boolean includeAll) {...}
	```
	This method will return a Picklist field's values' API and corresponding Label wrapped in PicklistFieldInfo class.

3. Get all the child relationships of a SObject.
	```java
	public static Map<String, String> getRelatedObjectsList(String objectAPI) {...}
	```
	In this method, pass the SObject API and it will return all the Child Relationship for the SObject.

### Clone the entire project:
```console
git clone https://github.com/SalesforceX/Utilities.git
```