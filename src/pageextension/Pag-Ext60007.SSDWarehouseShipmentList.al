pageextension 60007 "SSD Warehouse Shipment List" extends "Warehouse Shipment List"
{
    layout
    {
        addafter("Location Code")
        {
            field("SSD Combined With"; Rec."SSD Combined With")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Combined With field.', Comment = '%';
            }
            field("SSD Dock No."; Rec."SSD Dock No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dock No. field.', Comment = '%';
            }
            field("SSD Slot No."; Rec."SSD Slot No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot No. field.', Comment = '%';
            }
            field("SSD Slot Starting Time"; Rec."SSD Slot Starting Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot Starting Time field.', Comment = '%';
            }
            field("SSD Slot Ending Time"; Rec."SSD Slot Ending Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot Ending Time field.', Comment = '%';
            }
        }
    }
}
