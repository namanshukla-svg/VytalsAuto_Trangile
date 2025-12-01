pageextension 60027 "Sales Lines" extends "Sales Lines"
{
    layout
    {
        addafter("Outstanding Quantity")
        {
            field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the outstanding quantity expressed in the base units of measure.';
            }
        }
    }
}
