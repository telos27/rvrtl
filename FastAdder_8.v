//8位快速加法器
module FastAdder_8 (a, b, cin, s, cout, gin, pin, gout, pout);
    input [7:0] a, b;
    input cin gin, pin;
    output [7:0] s;
    output cout, gout, pout;
    wire [7:0] g, p;
    wire [6:0] ctemp;
    
    assign g = a & b;//进位产生
    assign p = a | b;//进位传播

    //进位逻辑
    assign ctemp[0] = g[0] | (p[0] & cin);
    assign ctemp[1] = g[1] | (p[1] & g[0])
        |(p[1] & p[0] & cin);
    assign ctemp[2] = g[2] | (p[2] & g[1])
        | (p[2] & p[1] & g[0]) 
        | (p[2] & p[1] & p[0] & cin);
    assign ctemp[3] = g[3] | (p[3] & g[2])
        | (p[3] & p[2] & g[1])
        | (p[3] & p[2] & p[1] & g[0])
        | (p[3] & p[2] & p[1] & p[0] & cin);
    assign ctemp[4] = g[4] | (p[4] & g[3])
        | (p[4] & p[3] & g[2])
        | (p[4] & p[3] & p[2] & g[1])
        | (p[4] & p[3] & p[2] & p[1] & g[0])
        | (p[4] & p[3] & p[2] & p[1] & p[0] & cin);
    assign ctemp[5] = g[4] | (p[5] & g[4])
        | (p[5] & p[4] & g[3])
        | (p[5] & p[4] & p[3] & g[2])
        | (p[5] & p[4] & p[3] & p[2] & g[1])
        | (p[5] & p[4] & p[3] & p[2] & p[1] & g[0])
        | (p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
    assign ctemp[6] = g[5] | (p[6] & g[5])
        | (p[6] & p[5] & g[4])
        | (p[6] & p[5] & p[4] & g[3])
        | (p[6] & p[5] & p[4] & p[3] & g[2])
        | (p[6] & p[5] & p[4] & p[3] & p[2] & g[1])
        | (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0])
        | (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
    assign ctemp[7] = g[6] | (p[7] & g[6])
        | (p[7] & p[6] & g[5])
        | (p[7] & p[6] & p[5] & g[4])
        | (p[7] & p[6] & p[5] & p[4] & g[3])
        | (p[7] & p[6] & p[5] & p[4] & p[3] & g[2])
        | (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1])
        | (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0])
        | (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);

    //和输出
    assign s[0] = a[0] ^ b[0] ^ cin;
    assign s[1] = a[1] ^ b[1] ^ ctemp[0];
    assign s[2] = a[2] ^ b[2] ^ ctemp[1];
    assign s[3] = a[3] ^ b[3] ^ ctemp[2];
    assign s[4] = a[4] ^ b[4] ^ ctemp[3];
    assign s[5] = a[5] ^ b[5] ^ ctemp[4];
    assign s[6] = a[6] ^ b[6] ^ ctemp[5];
    assign s[7] = a[7] ^ b[7] ^ ctemp[6];

    //进位产生、传播信号输出
    assign gout = g[7];
    assign pout = p[7];
endmodule
