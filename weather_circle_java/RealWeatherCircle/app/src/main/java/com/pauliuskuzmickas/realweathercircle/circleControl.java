package com.pauliuskuzmickas.realweathercircle;

import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.widget.Toast;
import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.os.AsyncTask;
import java.io.IOException;
import java.util.UUID;

import me.angrybyte.circularslider.CircularSlider;

public class circleControl extends ActionBarActivity implements CircularSlider.OnSliderMovedListener {

    String address = null;
    private ProgressDialog progress;
    BluetoothAdapter myBluetooth = null;
    CircularSlider cs;
    BluetoothSocket btSocket = null;
    private boolean isBtConnected = false;
    static final UUID myUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        Intent newint = getIntent();
        address = newint.getStringExtra(DeviceList.EXTRA_ADDRESS); //receive the address of the bluetooth device

        setContentView(R.layout.activity_circle_control);


        cs = (CircularSlider) findViewById(R.id.circular);
        new ConnectBT().execute(); //Call the class to connect

        cs.setOnSliderMovedListener(this);

    }


    // fast way to call Toast
    private void msg(String s)
    {
        Toast.makeText(getApplicationContext(),s,Toast.LENGTH_LONG).show();
    }

    double previousPos=0.22;

    @Override
    public void onSliderMoved(double pos) {
        if (btSocket!=null)
        {
            try
            {
                if(pos>previousPos) {
                    btSocket.getOutputStream().write(0);
                    previousPos=pos;
                    Log.d("socket", "writing 0");
                }
                else if(pos<previousPos) {
                     btSocket.getOutputStream().write(1);
                    previousPos=pos;
                    Log.d("socket", "writing 1");
                }



            }
            catch (IOException e)
            {
                msg("Error");
            }
        }
        else Log.d("socket", "socket null");
    }


    private class ConnectBT extends AsyncTask<Void, Void, Void>  // UI thread
    {
        private boolean ConnectSuccess = true; //if it's here, it's almost connected

        @Override
        protected void onPreExecute()
        {
            progress = ProgressDialog.show(circleControl.this, "Connecting...", "Please wait!!!");  //show a progress dialog
        }

        @Override
        protected Void doInBackground(Void... devices) //while the progress dialog is shown, the connection is done in background
        {
            try
            {
                if (btSocket == null || !isBtConnected)
                {
                    myBluetooth = BluetoothAdapter.getDefaultAdapter();//get the mobile bluetooth device
                    BluetoothDevice dispositivo = myBluetooth.getRemoteDevice(address);//connects to the device's address and checks if it's available
                    btSocket = dispositivo.createInsecureRfcommSocketToServiceRecord(myUUID);//create a RFCOMM (SPP) connection
                    BluetoothAdapter.getDefaultAdapter().cancelDiscovery();
                    btSocket.connect();//start connection
                }
            }
            catch (IOException e)
            {
                ConnectSuccess = false;//if the try failed, you can check the exception here
            }
            return null;
        }
        @Override
        protected void onPostExecute(Void result) //after the doInBackground, it checks if everything went fine
        {
            super.onPostExecute(result);

            if (!ConnectSuccess)
            {
                msg("Connection Failed. Try again.");
                finish();
            }
            else
            {
                msg("Connected.");
                isBtConnected = true;
            }
            progress.dismiss();
        }
    }
}
