page 60105 "SSD Item Category API"
{
    APIGroup = 'plantautomation';
    APIPublisher = 'ssd';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Item Category';
    DelayedInsert = true;
    EntityName = 'itemcat';
    EntitySetName = 'itemcategory';
    PageType = API;
    SourceTable = "Item Category";
    Editable = false;
    DataAccessIntent = ReadOnly;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(parentCategory; Rec."Parent Category")
                {
                    Caption = 'Parent Category';
                }
                field(presentationOrder; Rec."Presentation Order")
                {
                    Caption = 'Presentation Order';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                field(indentation; Rec.Indentation)
                {
                    Caption = 'Indentation';
                }
                field(hasChildren; Rec."Has Children")
                {
                    Caption = 'Has Children';
                }
            }
        }
    }
}
