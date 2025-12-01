page 60004 "SSD Driver"
{
    ApplicationArea = All;
    Caption = 'Driver';
    PageType = Card;
    SourceTable = "SSD Driver";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec)then CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                }
                field("Aadhar No."; Rec."Aadhar No.")
                {
                    ToolTip = 'Specifies the value of the Aadhar No. field.', Comment = '%';
                }
                field("License Type"; Rec."License Type")
                {
                    ToolTip = 'Specifies the value of the License Type field.', Comment = '%';
                }
                field("License No."; Rec."License No.")
                {
                    ToolTip = 'Specifies the value of the License No. field.', Comment = '%';
                }
                field("Driver Experience"; Rec."Driver Experience")
                {
                    ToolTip = 'Specifies the value of the Driver Experience field.', Comment = '%';
                }
                field("Driver Company Name"; Rec."Driver Company Name")
                {
                    ToolTip = 'Specifies the value of the Driver Company Name field.', Comment = '%';
                }
            }
        }
        area(factboxes)
        {
            part(DriverPicture; "SSD Driver Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = Code=field(Code);
            }
            part(DriverPicture2; "SSD Driver Aadhar Front")
            {
                ApplicationArea = All;
                Caption = 'Aadhar Front';
                SubPageLink = Code=field(Code);
            }
            part(DriverPicture3; "SSD Driver Aadhar Back")
            {
                ApplicationArea = All;
                Caption = 'Aadhar Back';
                SubPageLink = Code=field(Code);
            }
            part(DriverPicture4; "SSD Driver License Picture")
            {
                ApplicationArea = All;
                Caption = 'License';
                SubPageLink = Code=field(Code);
            }
            part(DriverPicture5; "SSD Driver Company Id")
            {
                ApplicationArea = All;
                Caption = 'Company Id';
                SubPageLink = Code=field(Code);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Activation)
            {
                action(Activate)
                {
                    ApplicationArea = All;
                    Caption = 'Activate';
                    Image = Action;
                    ToolTip = 'Executes the Activate action.';

                    trigger OnAction()
                    begin
                        Rec.ActivateDriver();
                    end;
                }
                action(DeActivate)
                {
                    ApplicationArea = All;
                    Caption = 'Deactivate';
                    Image = Cancel;
                    ToolTip = 'Executes the DeActivate action.';

                    trigger OnAction()
                    begin
                        Rec.DeactivateDriver();
                    end;
                }
            }
        }
        area(Navigation)
        {
            group(History)
            {
                action(Archive)
                {
                    ApplicationArea = All;
                    Image = Archive;
                    Caption = 'Archive';
                    ToolTip = 'Executes the Archive action.';

                    trigger OnAction()
                    var
                        SSDAutoArchiveManagement: Codeunit "SSD Auto Archive Management";
                    begin
                        SSDAutoArchiveManagement.ArchiveDriver(Rec);
                    end;
                }
            }
        }
        area(Promoted)
        {
            actionref(Activate_Promoted; Activate)
            {
            }
            actionref(DeActivate_Promoted; DeActivate)
            {
            }
        }
    }
}
