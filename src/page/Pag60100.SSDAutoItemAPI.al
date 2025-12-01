page 60100 "SSD Auto Item API"
{
    APIGroup = 'plantautomation';
    APIPublisher = 'ssd';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Automation Item API';
    DelayedInsert = true;
    EntityName = 'anzoitem';
    EntitySetName = 'anzoitems';
    PageType = API;
    SourceTable = Item;
    SourceTableView = sorting(Type)order(ascending)where(Type=const(Inventory));
    Editable = false;
    DataAccessIntent = ReadOnly;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(itemNumber; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(itemDescription; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(itemDescription2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field(baseUOM; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(itemType; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(itemSubType; Rec."SSD Item SubType")
                {
                    Caption = 'Item SubType';
                }
                field(lowFlash; Rec."SSD Low Flash")
                {
                    Caption = 'Low Flash';
                }
                field(palletTypePreference; Rec."SSD Pallet Type")
                {
                    Caption = 'Pallet Type';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                part(itemwarehouse; "SSD Item Whse Mapping")
                {
                    Caption = 'Item Warehouse Mapping';
                    //Multiplicity = ZeroOrOne;
                    EntityName = 'itemwhse';
                    EntitySetName = 'itemwarehouse';
                    SubPageLink = "Item No."=field("No.");
                }
            }
        }
    }
}
