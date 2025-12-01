pageextension 60011 "SSD Outward Gate Entry Subform" extends "Outward Gate Entry SubForm"
{
    layout
    {
        modify("Source Type")
        {
            Editable = false;
            Visible = false;
        }
        addbefore("Source No.")
        {
            field("SSD Source Type"; Rec."Source Type")
            {
                ApplicationArea = Basic, Suite;
                ValuesAllowed = " ", "Sales Order", "Purchase Return Order", "Outbound Transfer";
                ToolTip = 'Specifies the type of source document for which the document is created.';
            }
        }
    }
}
