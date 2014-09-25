-- Practicas de Sistemas Empotrados y de Tiempo Real
-- ETS de Ingenieria Informatica, Universidad Politecnica de Valencia
-- Practica 1
-- Ejercicios 3, 4, 5 y 6


with Ada.Text_IO, Ada.Integer_Text_IO;
use  Ada.Text_IO, Ada.Integer_Text_IO;

procedure Prac_1 is

  -- Space for the definition and 
  -- declaration of the buffer and the 
  -- procedures Add, Remove and Initialise
  N : constant Integer := 5;
  type Index is mod N;
  type Buffer is array (Index) of Integer;
  type Circular_Buffer is 
    record
	Queue	  : Buffer;
        Add_Index,
	Rem_Index : Index := 0;
	Counter   : Integer := 0;
    end record;
  My_Buffer: Circular_Buffer;

function Full (B : in Circular_Buffer) return Boolean is
begin
 if B.Counter = N-1 then
   return True;
 else
   return False;
 end if;
end Full;

function Empty (B : in Circular_Buffer) return Boolean is
begin
 if B.Counter = 0 then
   return True;
 else
   return False;
 end if;
end Empty;

procedure Initialise (B: in out Circular_Buffer) is
begin
  B.Add_Index := 0;
  B.Rem_Index := 0;
  B.Counter := 0;
end Initialise;

procedure Add (B: in out Circular_Buffer; I : in Integer) is
begin
 if not Full(B) then
   B.Queue(B.Add_Index) := I;
   B.Add_Index := B.Add_Index + 1;
   B.Counter := B.Counter + 1;
 end if;
end Add;

procedure Remove (B : in out Circular_Buffer; I : out integer) is
begin
 if not Empty(B) then
   I:= B.Queue(B.Rem_Index);
   B.Rem_Index := B.Rem_Index + 1;
   B.Counter := B.Counter - 1;
 end if;
end Remove;

procedure List (B: in out Circular_Buffer) is
myIndex : Index := B.Rem_index;
begin
 if Empty(B) then
   Put_Line(" Buffer empty.");
 else
   for I in 1..B.Counter loop
     Put(Integer'Image(B.Queue(myIndex)));
     if I /= B.Counter then
	Put(",");
     end if;
     myIndex := myIndex + 1;
   end loop;
 end if;

end List;

Command, Elem: Integer;
begin
  Put_Line("BUFFER MANAGER");
  loop
    Put_Line("1. Add element to buffer");
    Put_Line("2. Remove element from buffer");
    Put_Line("3. Initialise buffer");
    Put_Line("4. Buffer contents");
    Put_Line("0. Quit");
    Get(Command);
    case Command is
      when 1 =>
	if Full(My_Buffer) then 
	   Put_Line ("Buffer Full! Unable to add element!");
        else
           Put("Element to add:");
           Get(Elem);
           Add(My_Buffer,Elem);
	end if;
      when 2 =>
	if Empty(My_Buffer) then 
	   Put_Line ("Buffer Empty! Unable to remove element!");
        else
           Remove(My_Buffer,Elem);
           Put("Element removed:");
           Put(Elem);
           New_Line;
	end if;
      when 3 =>
        Initialise(My_Buffer);
      when 4 => 
	Put("Buffer elements:");
	List(My_Buffer);
	New_Line;
      when 0 =>
        exit;
      when  others => null;
    end case;
  end loop;
end Prac_1;


