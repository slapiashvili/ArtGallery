//
//  ArtGalleryItemView.swift
//  artGallery
//
//  Created by Salome Lapiashvili on 23.12.23.
//

import SwiftUI

struct ArtGalleryItemView: View {
    @ObservedObject var viewModel: ArtPieceViewModel
    //MARK: -properties:
    @State private var isDoubleTap = false
            //MARK: -gestures:
    private var rotationGesture: some Gesture {
        RotateGesture()
            .onChanged { gestureValue in
                let angle = gestureValue.rotation
                withAnimation(Animation.linear(duration: 0.1)) {
                    viewModel.rotation = angle
                }
                viewModel.currentGesture = "Rotate"
            }
            .onEnded { _ in
                withAnimation(Animation.linear(duration: 0.5)) {
                    viewModel.rotation = .degrees(0)  
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        viewModel.currentGesture = ""
                    }
                }
            }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(Animation.linear(duration: 1.0)) {
                    viewModel.offsetX += value.translation.width
                    viewModel.offsetY += value.translation.height
                }
                viewModel.currentGesture = "Drag"
            }
            .onEnded { _ in
                viewModel.currentGesture = ""
            }
    }


    private var tapGesture: some Gesture {
        TapGesture()
            .onEnded {
                withAnimation(Animation.spring(response: 0.5, dampingFraction: 0.7)) {
                    viewModel.scale *= 1.2
                }
                viewModel.currentGesture = "Tap"
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewModel.scale = 1.0
                    }
                }
            }
    }

    private var longPressGesture: some Gesture {
        LongPressGesture()
            .onChanged { _ in
                let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        viewModel.rotation = .degrees(20)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            viewModel.rotation = .degrees(0)
                        }
                    }
                }
                RunLoop.main.add(timer, forMode: .common)
            }
            .onEnded { _ in
                viewModel.rotation = .degrees(0)
                viewModel.scale = 1.0
                viewModel.currentGesture = "Long Press"
            }
    }




    private var doubleTapLongPressGesture: some Gesture {
        SimultaneousGesture(
            TapGesture(count: 2)
                .onEnded {
                    isDoubleTap = true
                    viewModel.currentGesture = "Double Tap"
                },
            LongPressGesture()
        )
        .onEnded { _ in
            withAnimation(Animation.interpolatingSpring(stiffness: 50, damping: 5).repeatForever(autoreverses: true)) {
                viewModel.scale *= 1.5
            }
            viewModel.currentGesture = "Double Tap + Long Press"
        }
    }
    
    private var magnificationGesture: some Gesture {
            MagnificationGesture()
                .onChanged { scale in
                    withAnimation {
                        viewModel.scale *= scale
                    }
                    viewModel.currentGesture = "Magnify"
                }
                .onEnded { _ in
                    viewModel.currentGesture = ""
                }
    }

        // MARK: - body
        var body: some View {
            VStack {
                Image(viewModel.artPiece.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .scaleEffect(viewModel.scale)
                    .rotationEffect(viewModel.rotation)
                    .offset(x: viewModel.offsetX, y: viewModel.offsetY)
                    .gesture(rotationGesture)
                    .gesture(dragGesture)
                    .gesture(tapGesture)
                    .gesture(longPressGesture)
                    .gesture(doubleTapLongPressGesture)
                    .gesture(magnificationGesture)

                Text("Current Gesture: \(viewModel.currentGesture)")
                    .font(.title3)
                    .foregroundColor(Color("darkBrown"))
                    .padding()
            }
            .background(Color("Cream").ignoresSafeArea())
        }
    }
