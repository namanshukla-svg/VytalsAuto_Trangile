page 60039 "SSD Quality Samples factbox"
{
    ApplicationArea = All;
    Caption = 'Quality Samples';
    PageType = ListPart;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    SourceTable = "SSD Quality Samples";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the value of the Package No. field.', Comment = '%';
                }
                field("New Sequence No."; Rec."New Sequence No.")
                {
                    Caption = 'Sample No.';
                    ToolTip = 'Specifies the value of the Sequence No. field.', Comment = '%';
                }
            }
        }
    }
}
