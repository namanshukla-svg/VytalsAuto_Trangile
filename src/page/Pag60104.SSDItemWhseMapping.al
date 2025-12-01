page 60104 "SSD Item Whse Mapping"
{
    APIGroup = 'plantautomation';
    APIPublisher = 'ssd';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Item Warehouse Mapping';
    DelayedInsert = true;
    EntityName = 'itemwhse';
    EntitySetName = 'itemwarehouse';
    PageType = API;
    SourceTable = "SSD Item Warehouse Mapping";
    ODataKeyFields = "Item No.";
    DataAccessIntent = ReadOnly;
    Editable = false;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(zonePreference1; Rec."SSD Zone Preference 1")
                {
                    Caption = 'Zone Preference 1';
                }
                field(zonePreference1Name; Rec."SSD Zone Preference 1 Name")
                {
                    Caption = 'Zone Preference 1 Name';
                }
                field(zonePreference2; Rec."SSD Zone Preference 2")
                {
                    Caption = 'Zone Preference 2';
                }
                field(zonePreference2Name; Rec."SSD Zone Preference 2 Name")
                {
                    Caption = 'Zone Preference 2 Name';
                }
                field(rejectZone; Rec."SSD Reject Zone")
                {
                    Caption = 'Hard Quarantine Zone';
                }
                field(rejectZoneName; Rec."SSD Reject Zone Name")
                {
                    Caption = 'Hard Quarantine Zone Name';
                }
            }
        }
    }
}
