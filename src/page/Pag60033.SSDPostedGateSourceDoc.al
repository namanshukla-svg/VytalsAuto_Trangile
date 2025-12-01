page 60033 "SSD Posted Gate Source Doc"
{
    Caption = 'Source Document Picture';
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Posted Gate Entry Header";

    layout
    {
        area(Content)
        {
            field(Picture; Rec."SSD Source Document")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for source document';
            }
        }
    }
}
