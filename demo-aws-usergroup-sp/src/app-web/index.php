<!DOCTYPE html>
<html lang="en-US">

<head>

    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <!-- SEO -->
    <title>DEMO TERRAFORM</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="images/favicon.png" sizes="32x32">

    <!-- Styles -->
    <link rel='stylesheet' href='assets/css/split.css' type='text/css' media='screen' />
    <meta name="viewport" content="width=device-width,initial-scale=1" />

</head>

<body id="fullsingle" class="page-template-page-fullsingle-split">

    <div class="fs-split">

        <!-- Image Side -->
        <div class="split-image">

        </div>

        <!-- Content Side -->
        <div class="split-content">

            <div class="split-content-vertically-center">

                <div class="split-intro">
                    
                    <?php
                    echo "<h1>";
                    echo "SERVER_IP: ";
                    echo $_SERVER['SERVER_ADDR'];
                    echo "<br>";
                    echo "SERVER_NAME: ";
                    echo $_SERVER['SERVER_NAME'];
                    echo "<br>";
                    echo "SERVER_PORT: ";
                    echo $_SERVER['SERVER_PORT'];
                    echo "<br>";
                    echo "REMOTE_IP: ";
                    echo $_SERVER['REMOTE_ADDR'];
                    echo "<br>";
                    echo "</h1>" 
                    ?>
                   
                    <br>

                    <span class="tagline">DEMO TERRAFORM <?php echo $_SERVER['SERVER_ADDR'] ?> </span>
                </div>

                

                <img src="images/terraform-logo.png" width="75%" height="75%">

                <div class="split-bio">

                    <p>Website demo via deploy com <a href="http://terraform.io">Terraform</a>.</p>
                    Source: <a href="https://github.com/valdecircarvalho/terraform-demo" target="_blank"> github.com/valdecircarvalho/terraform-demo</a>
                    <br>
                    Criado por: Valdecir Carvalho - <a href="http://homelaber.com.br" target="_blank">homelaber.com.br</a>
                </div>

                <div class="split-lists">


                    <div class="split-list">

                        <h3>Social</h3>

                        <ul>
                            <li><a href="https://twitter.com/homelaber" target="_blank">Twitter</a></li>
                            <li><a href="https://www.linkedin.com/in/valdecircarvalho/" target="_blank">Linkedin</a>
                            </li>
                            <li><a href="https://github.com/valdecircarvalho/" target="_blank">Github</a></li>
                        </ul>

                    </div>

                    <div class="split-list">

                        <h3>Connect</h3>

                        <ul>
                            <li><a href="http://homelaber.com.br/" target="_blank">Blog</a></li>
                            <li><a href="http://valdecir.me/" target="_blank">Site</a></li>
                            <li><a href="http://vbrownbagbrasil.com.br/" target="_blank">Podcast</a></li>
                        </ul>

                    </div>

                

                </div>

                <div class="split-credit">

                    <p>Source: <a href="https://onepagelove.com/split" target="_blank">Split Template</a>
                        by <a href="https://onepagelove.com" target="_blank">One Page Love</a></p>

                    <!-- 
				To edit this credit you can remove the CC3.0 license for only $5 here: https://onepagelove.com/split 
				this really helps contribute towards us developing more templates and means the world to me!
				Cheers, Rob (@robhope)
				-->

                </div>

            </div>

        </div>

    </div>

</body>

</html>