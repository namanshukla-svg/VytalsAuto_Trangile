pageextension 60023 "SSD Rcpt Quality Order Card" extends "Rcpt. Quality Order Card"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(Samples; "SSD Quality Samples factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=field("No.");
                SubPageView = sorting("New Sequence No.")order(descending);
            }
        }
    }
    actions
    {
        addbefore(Comments)
        {
            action(AssignSamples)
            {
                Caption = 'Assign Samples';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Process;
                ToolTip = 'Executes the Assign Samples action.';
                RunObject = Page "SSD Quality Samples";
                RunPageLink = "Document No."=field("No.");
            }
        }
    }
}
