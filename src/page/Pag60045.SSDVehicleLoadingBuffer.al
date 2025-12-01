page 60045 "SSD Vehicle Loading Buffer"
{
    ApplicationArea = All;
    Caption = 'Vehicle Loading Buffer';
    PageType = ListPart;
    SourceTable = "SSD Vehicle Loading Buffer";
    SourceTableView = sorting("Vehicle Loaded", "Package No.", "Shipment No.", "Location Code", "Dock No.")order(ascending);
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Shipment No."; Rec."Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Shipment No. field.', Comment = '%';
                }
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the value of the Package No. field.', Comment = '%';
                }
                field("Vehicle Loaded"; Rec."Vehicle Loaded")
                {
                    ToolTip = 'Specifies the value of the Vehicle Loaded field.', Comment = '%';
                }
            }
        }
    }
}
