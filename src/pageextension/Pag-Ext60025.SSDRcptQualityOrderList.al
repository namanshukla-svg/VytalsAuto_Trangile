pageextension 60025 "SSD Rcpt. Quality Order List" extends "Rcpt. Quality Order List"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(Samples; "SSD Quality Samples factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=field("No.");
            }
        }
    }
    actions
    {
        addfirst(Processing)
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
