table 60006 "SSD Vehicle"
{
    Caption = 'Vehicle';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
            //  TestNoSeries();
            end;
        }
        field(10; "Owner Name"; Text[100])
        {
            Caption = 'Owner Name';
        }
        field(15; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
        }
        field(20; "Email"; Text[80])
        {
            Caption = 'Email';
        }
        field(25; "Address"; Text[100])
        {
            Caption = 'Address';
        }
        field(30; "Vehicle Type";Enum "SSD License Type")
        {
            Caption = 'Vehicle Type';
        }
        field(35; "Make of Vehicle"; Text[100])
        {
            Caption = 'Make of Vehicle';
        }
        field(40; "Model"; Text[100])
        {
            Caption = 'Model';
        }
        field(45; "Vehicle Registration No."; Code[20])
        {
            Caption = 'Vehicle Registration No.';
        }
        field(50; "Polution End Date"; Date)
        {
            Caption = 'Polution End Date';
        }
        field(55; "Insurance End Date"; Date)
        {
            Caption = 'Insurance End Date';
        }
        field(58; "Fire Extinguisher"; Boolean)
        {
            Caption = 'Fire Extinguisher';
        }
        field(70; Active; Boolean)
        {
            Caption = 'Active';
            Editable = false;
        }
        field(92; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        field(95; "Vehicle RC"; MediaSet)
        {
            Caption = 'Vehicle RC';
        }
        field(100; "No. Plate"; MediaSet)
        {
            Caption = 'No. Plate';
        }
        field(105; "Chassis Number"; MediaSet)
        {
            Caption = 'Chassis Number';
        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(110; "Side Window"; MediaSet)
        {
            Caption = 'Side Window';
        }
        field(115; "Pollution Certificate"; MediaSet)
        {
            Caption = 'Pollution Certificate';
        }
        field(120; "Insurance"; MediaSet)
        {
            Caption = 'Insurance';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
    // if Code = '' then begin
    //     AutomationSetup.Get();
    //     AutomationSetup.TestField("Vehicle Nos.");
    //     "No. Series" := AutomationSetup."Vehicle Nos.";
    //     Code := NoSeries.GetNextNo("No. Series");
    // end;
    end;
    // procedure AssistEdit(OldVehicle: Record "SSD Vehicle"): Boolean
    // var
    //     SSDVehicle: Record "SSD Vehicle";
    // begin
    //     SSDVehicle := Rec;
    //     AutomationSetup.Get();
    //     AutomationSetup.TestField("Vehicle Nos.");
    //     if NoSeries.LookupRelatedNoSeries(AutomationSetup."Vehicle Nos.", OldVehicle."No. Series", SSDVehicle."No. Series") then begin
    //         SSDVehicle.Code := NoSeries.GetNextNo(SSDVehicle."No. Series");
    //         Rec := SSDVehicle;
    //         exit(true);
    //     end;
    // end;
    // local procedure TestNoSeries()
    // var
    //     SSDDriver: Record "SSD Driver";
    // begin
    //     if Code <> xRec.Code then
    //         if not SSDDriver.Get(Rec.Code) then begin
    //             AutomationSetup.Get();
    //             NoSeries.TestManual(AutomationSetup."Driver Nos.");
    //             "No. Series" := '';
    //         end;
    // end;
    procedure ActivateVehicle()
    begin
        if Active then exit;
        Active:=true;
        Modify(true);
    end;
    procedure DeactivateVehicle()
    begin
        if not Active then exit;
        Active:=false;
        Modify(true);
    end;
// var
//     AutomationSetup: Record "SSD Automation Setup";
//     NoSeries: Codeunit "No. Series";
}
