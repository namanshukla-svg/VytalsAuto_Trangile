table 60012 "SSD Quality Samples"
{
    Caption = 'Quality Samples';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(15; "Lot No."; Code[50])
        {
            Caption = 'Lot No.';
        }
        field(20; "Package No."; Code[50])
        {
            Caption = 'Package No.';
        }
        field(30; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
        }
        field(40; "New Sequence No."; Integer)
        {
            Caption = 'New Sequence No.';
        }
        field(50; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(60; "Qty (Base)"; Decimal)
        {
            Caption = 'Qty. (Base)';
        }
        field(70; "Quality Sample"; Boolean)
        {
            Caption = 'Quality Sample';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key1; "New Sequence No.")
        {
        }
    }
    procedure SelectSample()
    var
        SSDAutomationSetup: Record "SSD Automation Setup";
        SSDQualitySamples: Record "SSD Quality Samples";
        SampleCount: Integer;
        DoubleSampleErr: Label 'Package is already selected as Sample';
        MaxSampleErr: Label 'You cannot select more than %1 samples', Comment = '%1 = Sample Count';
    begin
        if Rec."Quality Sample" then Error(DoubleSampleErr);
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Max Sample Count");
        SSDQualitySamples.SetRange("Document No.", Rec."Document No.");
        SSDQualitySamples.SetFilter("Line No.", '<>%1', Rec."Line No.");
        SSDQualitySamples.SetRange("Quality Sample", true);
        if SSDQualitySamples.FindSet()then begin
            SampleCount:=SSDQualitySamples.Count;
            if SampleCount >= SSDAutomationSetup."Max Sample Count" then Error(MaxSampleErr, SSDAutomationSetup."Max Sample Count");
        end;
        Rec."Quality Sample":=true;
        Rec."New Sequence No.":=GetNewSequenceNo();
        Rec.Modify();
    end;
    procedure DeselectSample()
    begin
        if not "Quality Sample" then exit;
        Rec."Quality Sample":=false;
        ResetSequenceNo();
        Rec."New Sequence No.":=0;
        Rec.Modify();
    end;
    local procedure GetNewSequenceNo()NewSequenceNo: Integer var
        SSDQualitySamples: Record "SSD Quality Samples";
        MaxSequenceNoInt: Integer;
    begin
        MaxSequenceNoInt:=0;
        SSDQualitySamples.Reset();
        SSDQualitySamples.SetRange("Document No.", Rec."Document No.");
        if SSDQualitySamples.FindSet()then repeat if MaxSequenceNoInt < SSDQualitySamples."New Sequence No." then MaxSequenceNoInt:=SSDQualitySamples."New Sequence No.";
            until SSDQualitySamples.Next() = 0;
        NewSequenceNo:=MaxSequenceNoInt + 1;
    end;
    local procedure ResetSequenceNo()
    var
        SSDQualitySamples: Record "SSD Quality Samples";
    begin
        SSDQualitySamples.Reset();
        SSDQualitySamples.SetRange("Document No.", Rec."Document No.");
        SSDQualitySamples.SetFilter("Line No.", '<>%1', Rec."Line No.");
        if SSDQualitySamples.FindSet()then repeat if SSDQualitySamples."New Sequence No." > Rec."New Sequence No." then begin
                    SSDQualitySamples."New Sequence No."-=1;
                    SSDQualitySamples.Modify();
                end;
            until SSDQualitySamples.Next() = 0;
    end;
}
