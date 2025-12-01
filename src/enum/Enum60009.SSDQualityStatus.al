enum 60009 "SSD Quality Status"
{
    Extensible = true;

    value(0; " ")
    {
    Caption = ' ';
    }
    value(1; Quarantine)
    {
    Caption = 'Quarantine';
    }
    value(2; Passed)
    {
    Caption = 'Passed';
    }
    value(3; Failed)
    {
    Caption = 'Failed';
    }
}
