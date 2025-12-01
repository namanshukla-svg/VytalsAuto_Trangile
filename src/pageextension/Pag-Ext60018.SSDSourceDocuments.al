pageextension 60018 "SSD Source Documents" extends "Source Documents"
{
    layout
    {
        addafter("Destination No.")
        {
            field("SSD Destination Name"; Rec."SSD Destination Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Destination Name field.', Comment = '%';
            }
        }
    }
}
