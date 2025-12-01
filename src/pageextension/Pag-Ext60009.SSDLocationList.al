pageextension 60009 "SSD LocationList" extends "Location List"
{
    layout
    {
        addlast(Control1)
        {
            field("SSD Automated Plant"; Rec."SSD Automated Plant")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Automated Plant field.', Comment = '%';
            }
            field("Allow Print On SI"; Rec."Allow Print On SI")
            {
                ApplicationArea = all;
            }
        }
    }
}
