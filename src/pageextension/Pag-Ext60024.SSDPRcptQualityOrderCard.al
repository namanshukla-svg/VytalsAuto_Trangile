pageextension 60024 "SSD P Rcpt Quality Order Card" extends "Posted Rcpt Quality Order Card"
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
}
