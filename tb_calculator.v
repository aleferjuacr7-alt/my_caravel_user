// Módulo de Banco de Pruebas (Testbench)
`timescale 1ns/1ps

module tb_calculator;

    // Declaración de Señales de Conexión (Wire o Reg)
    reg  [7:0] A;
    reg  [7:0] B;
    reg  [1:0] op_code;
    wire [7:0] result;
    wire       carry_out;

    // Instancia del Módulo de Calculadora (DUT: Device Under Test)
    calculator DUT (
        .A(A),
        .B(B),
        .op_code(op_code),
        .result(result),
        .carry_out(carry_out)
    );

    // Bloque Inicial (Generación de Estímulos de Prueba)
    initial begin
        // Crear un archivo VCD (Value Change Dump) para GTKWave
        $dumpfile("calculator.vcd");
        $dumpvars(0, tb_calculator);
        
        // Inicialización
        A = 8'h00; B = 8'h00; op_code = 2'b00; #10; // Esperar 10ns

        $display("--- Prueba de Suma (00) ---");
        // Prueba 1: 5 + 3 = 8
        A = 8'd5; B = 8'd3; op_code = 2'b00; #10;
        $display("5 + 3 = %d, Carry: %b", result, carry_out);
        
        // Prueba 2: 250 + 10 = 4 (Con acarreo)
        A = 8'd250; B = 8'd10; op_code = 2'b00; #10;
        $display("250 + 10 = %d, Carry: %b", result, carry_out); // (260 - 256 = 4)

        $display("--- Prueba de Resta (01) ---");
        // Prueba 3: 10 - 4 = 6
        A = 8'd10; B = 8'd4; op_code = 2'b01; #10;
        $display("10 - 4 = %d, Carry: %b", result, carry_out);

        $display("--- Prueba de AND Lógico (10) ---");
        // Prueba 4: 12 (0C) AND 5 (05) = 4 (04)
        A = 8'h0C; B = 8'h05; op_code = 2'b10; #10;
        $display("12 & 5 = %d", result);

        $display("--- Prueba de OR Lógico (11) ---");
        // Prueba 5: 12 (0C) OR 5 (05) = 13 (0D)
        A = 8'h0C; B = 8'h05; op_code = 2'b11; #10;
        $display("12 | 5 = %d", result);
        
        // Finalizar simulación
        $finish;
    end

endmodule
