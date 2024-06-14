<%--
  Created by IntelliJ IDEA.
  User: minseok
  Date: 24. 6. 13.
  Time: 오전 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <title></title>
</head>
<style>
    .emailchecked{
        background-color: #e6e6e6;
        border: 1px solid #e6e6e6;
        border-radius: 5px;
        position: relative;
        width: 150px;
        height: 40px;
        top: 12px;
        left: -55px;
    }
    .container {
        position: relative;
        width: 300%;
        height: 100vh;
        overflow: hidden;
    }

    .page {
        position: absolute;
        width: 100%;
        height: 100%;
        transition: transform 0.6s ease-in-out;
    }

    #page2 {
        transform: translateX(300%);
    }
    .w-full {
        width: 90%;
    }

    .w-full1{
        width: 85%;
    }
    @media (min-width: 768px) {
        .md\:p-8 {
            padding: 2rem;
        }
    }
    .propileimg{
        border: 1px solid #ddd;
        width: 150px;
        height: 150px;
        border-radius: 200px;
        cursor: pointer;
    }
    .max-w-md {
        max-width: 35rem;
    }
</style>
<body>
<!--
// v0 by Vercel.
// https://v0.dev/t/ouRbB40Wl7q
-->

<div class="w-full mx-auto p-6 md:p-8 container">
    <h1 class="text-2xl font-bold mb-6 text-center">Register</h1>
    <form class="space-y-4">
        <div class="page" id="page1" style="width: 100%">
        <div style="padding-bottom: 15px; width: 40%; margin: auto;">
           <label
                    class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                    for="name">
                Name
            </label>
            <input
                    class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                    type="text"
                    id="name"
                    placeholder="Enter your full name"/>
        </div>
        <div style="padding-bottom: 15px; width: 40%; margin: auto;">
            <label
                    class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                    for="phone">
                Phone Number
            </label>
            <input
                    class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                    type="tel"
                    id="phone"
                    placeholder="Enter your phone number"/>
        </div>
        <div style="padding-bottom: 15px; width: 40%; margin: auto;">
            <label
                    class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                    for="address">
                Address
            </label>
            <input
                    class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                    type="text"
                    id="address"
                    placeholder="Enter your address"/>
        </div>
        <div class="flex items-center" style="padding-bottom: 15px; width: 40%; margin: auto;">
            <div class="flex-1">
                <label
                        class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                        for="email">
                    Email
                </label>
                <input
                        class="flex h-10 w-full1 rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                        type="email"
                        id="email"
                        placeholder="Enter your email"/>
            </div>
            <button class="emailchecked">
                Check Availability
            </button>
        </div>
            <div class="flex items-center" style="padding-bottom: 15px; width: 40%; margin: auto;">
                <div class="flex-1">
                    <label
                            class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                            for="email">
                        Email Check
                    </label>
                    <input
                            class="flex h-10 w-full1 rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                            id="emailcheck"
                            placeholder="email check"/>
                </div>
                <button class="emailchecked">
                    Check
                </button>
            </div>
        <div style="padding-bottom: 15px; width: 40%; margin: auto;">
            <label
                    class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                    for="password">
                Password
            </label>
            <input
                    class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                    type="password"
                    id="password"
                    placeholder="Enter your password"/>
        </div>
        <div style="padding-bottom: 15px; width: 40%; margin: auto;">
            <label
                    class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                    for="confirm-password">
                Confirm Password
            </label>
            <input
                    class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                    type="password"
                    id="confirm-password"
                    placeholder="Confirm your password"/>
        </div>
        <div style="padding-bottom: 15px; width: 40%; margin: auto;">
            <label
                    class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                    for="dob">
                Date of Birth
            </label>
            <input
                    class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                    type="date"
                    id="dob" style="margin-bottom: 15px;"/>
            <button
                    class="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 h-10 px-4 py-2 w-full bg-[#4CAF50] hover:bg-[#43a047] text-white"
                    type="button" id="next">
                Next
            </button>
        </div>
        </div>
        <div class="page" id="page2" style="width: 100%">
            <!--
            // v0 by Vercel.
            // https://v0.dev/t/d59eRWti5iV
            -->

            <div class="max-w-md mx-auto px-4 py-8 sm:px-6 lg:px-8">
                <div class="space-y-6">
                    <div>
                        <button
                                class="inline-flex items-center rounded-md border border-transparent bg-green-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2"
                                type="button" id="back" style="margin-bottom: 15px;">
                            back
                        </button>
                        <label for="nickname" class="block text-sm font-medium text-gray-700 ">
                            Nickname
                        </label>
                        <div class="mt-1 flex items-center">
                            <input
                                    id="nickname"
                                    type="text"
                                    class="block w-full rounded-md border-gray-300 shadow-sm focus:border-green-500 focus:ring-green-500 sm:text-sm"
                                    placeholder="Enter your nickname" style="height: 30px"/>
                            <button
                                    type="button"
                                    class="ml-3 inline-flex items-center rounded-md border border-transparent bg-green-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2">
                                Check Availability
                            </button>
                        </div>
                    </div>
                    <div style="padding-top: 15px;">
                        <label class="block text-sm font-medium text-gray-700 ">Default Profile Options</label>
                        <div class="mt-1 grid grid-cols-3 gap-3">
                            <div class="relative">
                                <div class="aspect-w-1 aspect-h-1 overflow-hidden rounded-full">
                                    <img src="https://t1.daumcdn.net/friends/prod/editor/dc8b3d02-a15a-4afa-a88b-989cf2a50476.jpg"
                                         alt="Profile 1" class="h-full w-full object-cover propileimg"
                                    onclick=""/>
                                </div>

                            </div>
                            <div class="relative">
                                <div class="aspect-w-1 aspect-h-1 overflow-hidden rounded-full">
                                    <img src="https://e7.pngegg.com/pngimages/170/523/png-clipart-kakaotalk-kakao-friends-sticker-kakaotalk-white-face-thumbnail.png"
                                         alt="Profile 2" class="h-full w-full object-cover propileimg"
                                    onclick=""/>
                                </div>
                            </div>
                            <div class="relative">
                                <div class="aspect-w-1 aspect-h-1 overflow-hidden rounded-full">
                                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWGkRSo6snU44wyzDqcXn9sjH3iynRMBcesw&s"
                                         alt="Profile 3" class="h-full w-full object-cover propileimg"
                                    onclick=""/>
                                </div>
                            </div>
                        </div>
                        <div class="mt-3"style="padding-top: 15px;">
                            <button
                                    type="button"
                                    class="inline-flex items-center rounded-md border border-transparent bg-green-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2">
                                <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="24"
                                        height="24"
                                        viewBox="0 0 24 24"
                                        fill="none"
                                        stroke="currentColor"
                                        stroke-width="2"
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        class="mr-2 h-5 w-5">
                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                    <polyline points="17 8 12 3 7 8"></polyline>
                                    <line x1="12" x2="12" y1="3" y2="15"></line>
                                </svg>
                                Upload Photo
                            </button>
                        </div>
                    </div>
                    <div>
                        <button
                                type="button"
                                class="w-full inline-flex items-center justify-center rounded-md border border-transparent bg-green-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2">
                            Complete Registration
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
</div>



<script>
    $("#next").click(function (){
        $("#page1").css("transform", "translateX(-100%)");
        $("#page2").css("transform", "translateX(0)");
    })
    $("#back").click(function (){
        $("#page1").css("transform", "translateX(0)");
        $("#page2").css("transform", "translateX(100%)");
    })
</script>
</body>
</html>