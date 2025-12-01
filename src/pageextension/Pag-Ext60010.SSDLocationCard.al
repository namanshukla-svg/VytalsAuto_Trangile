pageextension 60010 "SSD LocationCard" extends "Location Card"
{
    layout
    {
        addlast("Purch., Sales & Transfer")
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
