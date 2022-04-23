#include <QtWidgets>
#include <QMessageBox>
#include <stdio.h>
#include <gpiod.h>
#include <unistd.h>
#include "components.h"
#include "window.h"

#define LED_PIN         4
#define RPI_COMPILE     1

/*
* A signal is a message that an object can send, most of the time to inform of a status change.
* A slot is a function that is used to accept and respond to a signal. From - https://wiki.qt.io/Qt_for_Beginners.
* Read uptil - Transmitting information.
*/
//connect(obj1,signal1,obj2,slot2)

Window::Window()
{
    components = new Components;
    QVBoxLayout *vlayout = new QVBoxLayout;//main vertical layout
    QHBoxLayout *hlayout = new QHBoxLayout;

    /*Buttons*/
    QPushButton *button1 = new QPushButton("Turn light on");
    QPushButton *statusButton = new QPushButton("Get light status");
    QPushButton *button2 = new QPushButton("View Logs");
    button1->setStyleSheet("background-color:red;font-size: 25px;height: 36px;width: 80px;");
    button2->setStyleSheet("background-color:orange;font-size: 25px;height: 36px;width: 80px;");

    /*Button action*/
    connect(button1,SIGNAL(clicked()),this,SLOT(handle_button1()));
    connect(button2,SIGNAL(clicked()),this,SLOT(handle_button2()));
    connect(statusButton,SIGNAL(clicked()),this,SLOT(handle_statusButton()));

    hlayout->addWidget(button1);
    hlayout->addWidget(button2);

    vlayout->addWidget(components);//vertical-layout within vertical-layout
    vlayout->addLayout(hlayout);//horizontal-layout within vertical-layout


    setLayout(vlayout);

}

int Window::handle_button1(){

    /*QMessageBox *msgbox = new QMessageBox;

    QFile *file = new QFile ("/var/tmp/tmplog.txt");

    if (file->open (QIODevice::ReadOnly) == true)
    {
        msgbox->setText(QString (file->readAll ()));
        file->close();
    }

    msgbox->exec();*/
    printf("TOGGLE GPIO\n");
#if (RPI_COMPILE == 1)
    struct gpiod_chip *chip;
    struct gpiod_line *line;
    int retv;

    chip = gpiod_chip_open("/dev/gpiochip0");
    if (!chip)
       return -1;

    //Get the handle to GPIO line at given offset
    line = gpiod_chip_get_line(chip, LED_PIN);
    if(line == 0){
        gpiod_chip_close(chip);
        return -1;
    }

    //set GPIO direction output
    retv = gpiod_line_request_output(line, "foobar", 1);
    if (retv)
    {
     gpiod_chip_close(chip);
     return -1;
    }

    retv = gpiod_line_set_value(line, 1);
    if(retv == -1){
        printf("Error writing value to GPIO!");
    }

    sleep(3);

    gpiod_chip_close(chip);

#endif
    return 0;
}

void Window::handle_statusButton(){



}

void Window::SloTempChanged(float temp)
{
    components->SloTempChanged(temp);
}

void Window::SloHumChanged(float hum){

    components->SloHumChanged(hum);

}

void Window::SloIrChanged(int ir)
{
    components->SloIrChanged(ir);
}

void Window::SloFullChanged(int full){

    components->SloFullChanged(full);

}

void Window::SloVisChanged(int vis){

    components->SloVisChanged(vis);

}

void Window::handle_button2()
{
    //Add log file open.
    QMessageBox *msgBox = new QMessageBox;

    QFile logFile("/var/tmp/log-file.txt");

    if(logFile.open(QIODevice::ReadOnly) == true){
        msgBox->setText(QString(logFile.readAll()));
        logFile.close();
    }

    msgBox->exec();

}
