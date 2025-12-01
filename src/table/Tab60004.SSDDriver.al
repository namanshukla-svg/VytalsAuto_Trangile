table 60004 "SSD Driver"
{
    Caption = 'Driver';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                TestNoSeries();
            end;
        }
        field(10; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(15; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(20; "Identification Type";Enum "SSD Identification Type")
        {
            Caption = 'Identification Type';
        }
        field(21; "Identification No."; Code[30])
        {
            Caption = 'Identification No.';
        }
        field(30; "Aadhar No."; Code[16])
        {
            Caption = 'Aadhar No.';
        }
        field(31; "License Type";Enum "SSD License Type")
        {
            Caption = 'License Type';
        }
        field(32; "License No."; Code[20])
        {
            Caption = 'License No.';
        }
        field(35; "Driver Experience"; Integer)
        {
            Caption = 'Driver Experience';
        }
        field(40; "Driver Company Name"; Text[100])
        {
            Caption = 'Driver Company Name';
        }
        field(50; Active; Boolean)
        {
            Caption = 'Active';
            Editable = false;
        }
        field(92; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        field(102; "Aadhar Photo Front"; MediaSet)
        {
            Caption = 'Aadhar Photo Front';
        }
        field(103; "Aadhar Photo Back"; MediaSet)
        {
            Caption = 'Aadhar Photo Back';
        }
        field(104; "License Picture"; MediaSet)
        {
            Caption = 'License Picture';
        }
        field(105; "Company Id"; MediaSet)
        {
            Caption = 'Company Id';
        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name, "Aadhar No.", Address, "License No.")
        {
        }
        fieldgroup(Brick; Code, Name, "Aadhar No.", Picture)
        {
        }
    }
    trigger OnInsert()
    begin
        if Code = '' then begin
            AutomationSetup.Get();
            AutomationSetup.TestField("Driver Nos.");
            "No. Series":=AutomationSetup."Driver Nos.";
            Code:=NoSeries.GetNextNo("No. Series");
        end;
    end;
    procedure AssistEdit(OldDriver: Record "SSD Driver"): Boolean var
        SSDDriver: Record "SSD Driver";
    begin
        SSDDriver:=Rec;
        AutomationSetup.Get();
        AutomationSetup.TestField("Driver Nos.");
        if NoSeries.LookupRelatedNoSeries(AutomationSetup."Driver Nos.", OldDriver."No. Series", SSDDriver."No. Series")then begin
            SSDDriver.Code:=NoSeries.GetNextNo(SSDDriver."No. Series");
            Rec:=SSDDriver;
            exit(true);
        end;
    end;
    procedure ArchiveDriver()
    var
        SSDDriverArchive: Record "SSD Driver Archive";
        NewVersionNo: Integer;
    begin
        SSDDriverArchive.SetRange(Code, Code);
        if SSDDriverArchive.FindLast()then NewVersionNo:=SSDDriverArchive."Archive No." + 1
        else
            NewVersionNo:=1;
        SSDDriverArchive.Init();
        SSDDriverArchive.TransferFields(Rec);
        SSDDriverArchive."Archive No.":=NewVersionNo;
        SSDDriverArchive.Insert();
        ResetData();
    end;
    local procedure ResetData()
    begin
        Rec.Name:='';
        "Identification Type":="Identification Type"::" ";
        "Identification No.":='';
    end;
    procedure ActivateDriver()
    begin
        if Active then exit;
        Active:=true;
        Modify(true);
    end;
    procedure DeactivateDriver()
    begin
        if not Active then exit;
        Active:=false;
        Modify(true);
    end;
    local procedure TestNoSeries()
    var
        SSDDriver: Record "SSD Driver";
    begin
        if Code <> xRec.Code then if not SSDDriver.Get(Rec.Code)then begin
                AutomationSetup.Get();
                NoSeries.TestManual(AutomationSetup."Driver Nos.");
                "No. Series":='';
            end;
    end;
    var AutomationSetup: Record "SSD Automation Setup";
    NoSeries: Codeunit "No. Series";
}
