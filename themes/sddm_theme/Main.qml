import QtQuick 2.0
import SddmComponents 2.0
import QtMultimedia 5.0
import QtQuick.Window 2.0
import QtQuick.Particles 2.0
import "Components"

Rectangle {
    id: container
    width: Screen.width
    height: Screen.height

    Connections {
        target: sddm
        onLoginSucceeded: {}
        onLoginFailed: {
            errorMessage.text = textConstants.loginFailed
            password.text = ""
        }
    }

    Item {
        anchors.fill: parent

        /********* Background Video *********/
        Video {
            id: backgroundVideo
            anchors.fill: parent
            source: "login.mp4"
            autoPlay: true
            loops: MediaPlayer.Infinite
            fillMode: VideoOutput.PreserveAspectCrop
            muted: true
        }

        /********* Audio *********/
        Audio {
            id: musicPlayer
            autoLoad: false
            source: "resources/bgm.ogg"
            loops: -1
        }

        /********* Particles *********/
        ParticleSystem { id: bgparticle; paused: true }
        Emitter {
            anchors.fill: parent
            system: bgparticle
            emitRate: 80
            lifeSpan: 4000
            lifeSpanVariation: 2000
            size: 3
            sizeVariation: 8
            endSize: 3
            startTime: 1000
            velocity: AngleDirection { angle: 270; angleVariation: 30; magnitude: 40; magnitudeVariation: 20 }

            ImageParticle {
                anchors.fill: parent
                system: bgparticle
                source: "resources/lightparticle.png"
            }

            Attractor {
                system: bgparticle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: parent.width * 0.08
                anchors.verticalCenterOffset: -parent.height * 0.1
                width: parent.width * 0.5
                height: 200
                pointX: parent.width * 0.25
                pointY: 0
                strength: 0.2
            }
        }

        ParticleSystem { id: spiral; paused: true }
        Emitter {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.2
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.24
            width: parent.width * 0.38
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.24
            system: spiral
            emitRate: 10
            lifeSpan: 3000
            lifeSpanVariation: 2000
            size: 6
            sizeVariation: 3
            endSize: 3
            startTime: 3000
            velocity: AngleDirection { angle: 270; angleVariation: 20; magnitude: 80; magnitudeVariation: 40 }

            ImageParticle {
                anchors.fill: parent
                system: spiral
                source: "resources/lightparticle.png"
            }

            Wander {
                system: spiral
                height: parent.height
                width: parent.width
                y: -parent.width * 0.2
                anchors.bottom: parent.bottom
                affectedParameter: Wander.Position
                pace: 1000
                xVariance: parent.width * 2
            }
        }

        /********* Login Area *********/
        Rectangle {
            id: loginArea
            anchors.fill: parent
            color: "transparent"
            visible: primaryScreen

            Column {
                id: mainColumn
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -120
                spacing: 36

                /********* Clock *********/
                Text {
                    id: clock
                    text: Qt.formatTime(new Date(), "hh:mm")
                    font.pixelSize: 140
                    font.bold: true
                    color: "#cdd6f4"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clock.text = Qt.formatTime(new Date(), "hh:mm")
                    }
                }

		/********* Password *********/
		PasswordBox {
			id: password
			width: 240
			height: 50
			radius: 40
			color: "transparent"
                    	anchors.horizontalCenter: parent.horizontalCenter
			font.pixelSize: 24
			focus: true

			Keys.onPressed: {
				if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
					sddm.login("<your username here>", password.text, 0)
					event.accepted = true
				}
			}
		}

                /********* Error Message *********/
                Text {
                    id: errorMessage
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: " "
                    font.pixelSize: 16
                    color: "#f38bac"
                }
            }
        }

        Component.onCompleted: {
            musicPlayer.play()
            bgparticle.resume()
            spiral.resume()
        }
    }
}


