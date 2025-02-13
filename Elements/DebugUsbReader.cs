using Godot;
using Godot.Collections;
using System;
using System.IO;
using System.Threading.Tasks;

using InTheHand.Net.Bluetooth;
using InTheHand.Net.Sockets;
using System.Collections.Generic;
using System.Reflection.Emit;
using InTheHand.Net;

public partial class DebugUsbReader : Node2D
{

	Timer Counter;
	RichTextLabel Sign;

	string Message;

	[Signal]
	public delegate void OnUpdateEventHandler(string message);

	// Bluetooth Address of the server device (Change this to your target device)
	BluetoothAddress serverAddress = BluetoothAddress.Parse("00:1A:7D:DA:71:13");

	// The RFCOMM service GUID (Common for SPP devices, but may need to be changed)
	Guid serviceUuid = BluetoothService.SerialPort;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		var adapter = BluetoothService.ServiceDiscoveryServer;

		if (adapter == null)
		{
			Console.WriteLine("No Bluetooth adapter found.");
		}
		else if (!adapter.IsEnabled)
		{
			Console.WriteLine("Bluetooth is disabled. Enable it first.");

		}
		Sign = GetNode<RichTextLabel>("RichTextLabel");

		Sign.Text = "SigmaBalls";
		start();

		/*try
		{*/
		try
		{
			BluetoothClient client = new BluetoothClient();
			client.Connect(new BluetoothEndPoint(serverAddress, serviceUuid)); 

			
			Sign.Text += ("Connected to Bluetooth server!");


			// Read response
			StreamReader reader = new StreamReader(client.GetStream());
			string response = reader.ReadLine();
			Sign.Text += ("Received: " + response);

			// Close connection
			reader.Close();
			client.Close();
		}
		catch (Exception ex)
		{
			Sign.Text += ("Error: " + ex.Message);
		}
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
	public void start()
	{

		//if (true) { Counter.Start(); }
	}

	public void stop()
	{

		Counter.Stop();
	}


	public void on_Timeout()
	{


		Sign.Text = "Arduino data: " + Message;

		//EmitSignal(SignalName.OnUpdate, Message);
	}
}
