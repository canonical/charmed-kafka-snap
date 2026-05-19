CG_OUT_1 = """

Consumer group 'cg1' has no active members.

GROUP           TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID     HOST            CLIENT-ID
cg1             t1              0          0               351             351             -               -               -
cg1             t1              1          100             329             229             -               -               -
cg1             t1              2          0               320             320             -               -               -

GROUP           TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID                                           HOST            CLIENT-ID
cg2             t1              0          351             351             0               console-consumer-a1ab5d8f-bfbf-42b6-9b3a-a4de970fe095 /10.57.152.204  console-consumer
cg2             t1              1          329             329             0               console-consumer-a1ab5d8f-bfbf-42b6-9b3a-a4de970fe095 /10.57.152.204  console-consumer
cg2             t1              2          320             320             0               console-consumer-a1ab5d8f-bfbf-42b6-9b3a-a4de970fe095 /10.57.152.204  console-consumer
"""

CG_OUT_2 = """

Consumer group 'cg1' has no active members.

GROUP           TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID     HOST            CLIENT-ID
cg1             t1              0          0               351             351             -               -               -
cg1             t1              1          100             329             229             -               -               -
cg1             t1              2          0               320             320             -               -               -

Consumer group 'cg2' has no active members.

GROUP           TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID     HOST            CLIENT-ID
cg2             t1              0          351             351             0               -               -               -
cg2             t1              1          329             329             0               -               -               -
cg2             t1              2          320             320             0               -               -               -

Consumer group 'long-john-silver' has no active members.

GROUP            TOPIC           PARTITION  CURRENT-OFFSET  LOG-END-OFFSET  LAG             CONSUMER-ID     HOST            CLIENT-ID
long-john-silver t1              0          197             351             154             -               -               -
long-john-silver t1              1          149             329             180             -               -               -
long-john-silver t1              2          320             320             0               -               -               -
"""
