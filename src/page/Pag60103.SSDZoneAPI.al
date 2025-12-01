page 60103 "SSD Zone API"
{
    APIGroup = 'plantautomation';
    APIPublisher = 'ssd';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Zone API';
    DelayedInsert = true;
    EntityName = 'zone';
    EntitySetName = 'zones';
    PageType = API;
    SourceTable = "SSD ASRS Zone";
    Editable = false;
    DataAccessIntent = ReadOnly;
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
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
