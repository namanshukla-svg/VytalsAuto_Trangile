page 60101 "SSD UOM API"
{
    APIGroup = 'plantautomation';
    APIPublisher = 'ssd';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'UOM';
    DelayedInsert = true;
    EntityName = 'uom';
    EntitySetName = 'uoms';
    PageType = API;
    SourceTable = "Unit of Measure";
    Editable = false;
    DataAccessIntent = ReadOnly;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
