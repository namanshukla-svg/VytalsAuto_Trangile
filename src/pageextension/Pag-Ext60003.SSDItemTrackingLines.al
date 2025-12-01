pageextension 60003 "SSD ItemTracking Lines" extends "Item Tracking Lines"
{
    layout
    {
        addafter("Quantity (Base)")
        {
            field("SSD Gross Weight"; Rec."SSD Gross Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gross Weight field.', Comment = '%';
            }
            field("SSD Entry Synced"; Rec."SSD Entry Synced")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Entry Synced field.', Comment = '%';
            }
        }
    }
}
