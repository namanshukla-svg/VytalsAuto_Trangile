pageextension 60029 "SSD Item Tracking Card" extends "Item Tracking Code Card"
{
    layout
    {
        addafter(Description)
        {
            field("SSD Blocked"; Rec."SSD Blocked")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
            }
        }
    }
}
