pageextension 60015 "SSD Warehouse Setup" extends "Warehouse Setup"
{
    layout
    {
        addlast(General)
        {
            field("SSD Pallet Planning Days"; Rec."SSD Pallet Planning Days")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pallet Planning Days field.', Comment = '%';
            }
            field("Internal Instance"; Rec."SSD Internal Instance")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Internal Instance field.', Comment = '%';
            }
        }
    }
}
