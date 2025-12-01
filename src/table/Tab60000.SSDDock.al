table 60000 "SSD Dock"
{
    Caption = 'Dock';
    DataClassification = CustomerContent;
    LookupPageId = "SSD Docks";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(5; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50; Status;Enum "SSD Dock Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(100; "Planned Receipts"; Integer)
        {
            Caption = 'Planned Receipts';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Warehouse Receipt Header" where("SSD Status"=const("SSD Receipt Status"::Planned), "Location Code"=field("Location Code"), "SSD Dock No."=field(Code)));
        }
        field(110; "Planned Shipments"; Integer)
        {
            Caption = 'Planned Shipments';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Warehouse Shipment Header" where(Status=const(Released), "Location Code"=field("Location Code"), "SSD Dock No."=field(Code)));
        }
        field(120; "Waiting Receipts"; Integer)
        {
            Caption = 'Waiting Receipts';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("SSD Dock Lines" where("Entry Type"=const(Inward), "Location Code"=field("Location Code"), "Dock No."=field(Code), Status=const(Waiting)));
        }
        field(130; "Waiting Shipments"; Integer)
        {
            Caption = 'Waiting Shipments';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("SSD Dock Lines" where("Entry Type"=const(Outward), "Location Code"=field("Location Code"), "Dock No."=field(Code), Status=const(Waiting)));
        }
        field(140; "In-Process Receipts"; Integer)
        {
            Caption = 'In-Process Receipts';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("SSD Dock Lines" where("Entry Type"=const(Inward), "Location Code"=field("Location Code"), "Dock No."=field(Code), Status=const("In-Process")));
        }
        field(150; "In-Process Shipments"; Integer)
        {
            Caption = 'In-Process Shipments';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("SSD Dock Lines" where("Entry Type"=const(Outward), "Location Code"=field("Location Code"), "Dock No."=field(Code), Status=const("In-Process")));
        }
        field(160; "Completed Receipts"; Integer)
        {
            Caption = 'Completed Receipts';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("SSD Dock Lines" where("Entry Type"=const(Inward), "Location Code"=field("Location Code"), "Dock No."=field(Code), Status=const(Completed)));
        }
        field(170; "Completed Shipments"; Integer)
        {
            Caption = 'Completed Shipments';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("SSD Dock Lines" where("Entry Type"=const(Outward), "Location Code"=field("Location Code"), "Dock No."=field(Code), Status=const(Completed)));
        }
        field(180; "Dock-Out Receipts"; Integer)
        {
            Caption = 'Dock-Out Receipts';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("SSD Dock Lines" where("Entry Type"=const(Inward), "Location Code"=field("Location Code"), "Dock No."=field(Code), Status=const("Dock Out")));
        }
        field(190; "Dock-Out Shipments"; Integer)
        {
            Caption = 'Dock-Out Shipments';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("SSD Dock Lines" where("Entry Type"=const(Outward), "Location Code"=field("Location Code"), "Dock No."=field(Code), Status=const("Dock Out")));
        }
    }
    keys
    {
        key(PK; "Location Code", "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Location Code", Code, "Planned Receipts", "Planned Shipments")
        {
        }
    }
}
