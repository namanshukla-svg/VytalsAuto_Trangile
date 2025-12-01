page 60007 "SSD Vehicle"
{
    ApplicationArea = All;
    Caption = 'Vehicle';
    PageType = Card;
    SourceTable = "SSD Vehicle";
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
                // trigger OnAssistEdit()
                // begin
                //     if Rec.AssistEdit(xRec) then
                //         CurrPage.Update();
                // end;
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ToolTip = 'Specifies the value of the Vehicle Type field.', Comment = '%';
                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle Registration No. field.', Comment = '%';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ToolTip = 'Specifies the value of the Owner Name field.', Comment = '%';
                }
                field("Chassis Number"; Rec."Chassis Number")
                {
                    ToolTip = 'Specifies the value of the Chassis Number field.', Comment = '%';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.', Comment = '%';
                }
                field("Make of Vehicle"; Rec."Make of Vehicle")
                {
                    ToolTip = 'Specifies the value of the Make of Vehicle field.', Comment = '%';
                }
                field("Polution End Date"; Rec."Polution End Date")
                {
                    ToolTip = 'Specifies the value of the Polution End Date field.', Comment = '%';
                }
                field("Insurance End Date"; Rec."Insurance End Date")
                {
                    ToolTip = 'Specifies the value of the Insurance End Date field.', Comment = '%';
                }
                field("Fire Extinguisher"; Rec."Fire Extinguisher")
                {
                    ToolTip = 'Specifies the value of the Fire Extinguisher field.', Comment = '%';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
            }
        }
        area(factboxes)
        {
            part(VehiclePicture; "SSD Vehicle Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = Code=field(Code);
            }
            part(VehiclePicture2; "SSD Vehicle RC Picture")
            {
                ApplicationArea = All;
                Caption = 'RC';
                SubPageLink = Code=field(Code);
            }
            part(VehiclePicture3; "SSD Vehicle No. Plate Picture")
            {
                ApplicationArea = All;
                Caption = 'No. Plate';
                SubPageLink = Code=field(Code);
            }
            part(VehiclePicture4; "SSD Vehicle Chassis Picture")
            {
                ApplicationArea = All;
                Caption = 'Chassis Number';
                SubPageLink = Code=field(Code);
            }
            part(VehiclePicture5; "SSD Vehicle Sidewindow Picture")
            {
                ApplicationArea = All;
                Caption = 'Sidewindow';
                SubPageLink = Code=field(Code);
            }
            part(VehiclePicture6; "SSD Vehicle Pollution Picture")
            {
                ApplicationArea = All;
                Caption = 'Pollution';
                SubPageLink = Code=field(Code);
            }
            part(VehiclePicture7; "SSD Vehicle Insurance Picture")
            {
                ApplicationArea = All;
                Caption = 'Insurance';
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
                        Rec.ActivateVehicle();
                    end;
                }
                action(DeActivate)
                {
                    ApplicationArea = All;
                    Caption = 'DeActivate';
                    Image = Cancel;
                    ToolTip = 'Executes the DeActivate action.';

                    trigger OnAction()
                    begin
                        Rec.DeactivateVehicle();
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
