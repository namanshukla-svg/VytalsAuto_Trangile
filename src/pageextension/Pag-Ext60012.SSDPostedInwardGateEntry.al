pageextension 60012 "SSD Posted Inward Gate Entry" extends "Posted Inward Gate Entry"
{
    layout
    {
        modify("Vehicle No.")
        {
            Visible = false;
        }
        modify("Station From/To")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Caption = 'GateIn-Date';
        }
        modify("Document Time")
        {
            Caption = 'GateIn-Time';
        }
        addlast(General)
        {
            field("SSD Planning No."; Rec."SSD Planning No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Planning No. field.', Comment = '%';
            }
            field("SSD Dock No."; Rec."SSD Dock No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dock No. field.', Comment = '%';
            }
            field("SSD Slot No."; Rec."SSD Time Slot No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot No. field.', Comment = '%';
            }
            field("SSD Slot Starting Time"; Rec."SSD Time Slot Starting Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot Starting Time field.', Comment = '%';
            }
            field("SSD Slot Ending Time"; Rec."SSD Time Slot Ending Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot Ending Time field.', Comment = '%';
            }
            field("SSD Material Type"; Rec."SSD Material Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Material Type field.', Comment = '%';
            }
            field("SSD Driver Code"; Rec."SSD Driver Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Driver Code field.', Comment = '%';
            }
            field("SSD Driver Name"; Rec."SSD Driver Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Driver Name field.', Comment = '%';
            }
            field("SSD Vehicle No."; Rec."SSD Vehicle No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Vehicle No. field.', Comment = '%';
            }
            field("SSD Vehicle Status"; Rec."SSD Vehicle Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SSD Vehicle Status field.', Comment = '%';
            }
            field("SSD Gate Out DateTime"; Rec."SSD Gate Out DateTime")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inward Gate Out DateTime field.', Comment = '%';
            }
        }
        addfirst(FactBoxes)
        {
            part(GateInPicture; "SSD Posted Gate In Picture")
            {
                ApplicationArea = All;
                Caption = 'Gate-In';
                SubPageLink = "Entry Type"=field("Entry Type"), "No."=field("No.");
            }
            part(GateOutPicture; "SSD Posted Gate Out Picture")
            {
                ApplicationArea = All;
                Caption = 'Gate-Out';
                SubPageLink = "Entry Type"=field("Entry Type"), "No."=field("No.");
            }
            part(SourceDocumentPicture; "SSD Posted Gate Source Doc")
            {
                ApplicationArea = All;
                Caption = 'Source Document';
                SubPageLink = "Entry Type"=field("Entry Type"), "No."=field("No.");
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            group(GateOut)
            {
                action(PostGateOut)
                {
                    Caption = 'Post Gate Out';
                    ApplicationArea = All;
                    Image = Post;
                    ToolTip = 'Executes the Post Gate Out action.';

                    trigger OnAction()
                    begin
                        Rec.PostInwardGateOut(Rec);
                    end;
                }
            }
        }
        addfirst(Promoted)
        {
            group(Posting)
            {
                actionref(PostGateOut_Promoted; PostGateOut)
                {
                }
            }
        }
    }
}
