const path = require("path")
const multer = require("multer")

const fileSize = 5 * 1024 * 1024
const imageFilter = (req, file, fun) => {
    if ((!file.originalname.match(/\.(jpg|jpeg|png)$/))
        && (file.mimetype !== "image/jpg")
        && (file.mimetype !== "image/jpeg")
        && (file.mimetype !== "image/png")) {
        fun(new Error('Only JPEG-PNG-JPG Are Allowed').message, false)
        return
    }
    fun(null, true)
}

const userImageHandler = multer({
    storage: multer.diskStorage({
        destination: (req, file, fun) => {
            fun(null, 'images/users')
        },
        filename: (req, file, fun) => {
            let name = Date.now() + path.extname(file.originalname)
            req.profilePic = name
            fun(null, name)
        },
    }),
    limits: fileSize,
    fileFilter: imageFilter
})


const orgImageHandler = multer({
    storage: multer.diskStorage({
        destination: (req, file, fun) => {
            if (file.fieldname == 'orgPic') {
                fun(null, 'images/orgs/org_images')
            }
            else if (file.fieldname == 'orgBackgroundPic') {
                fun(null, 'images/orgs/background_images')
            }
        },
        filename: (req, file, fun) => {
            let name = Date.now() + path.extname(file.originalname)
            if (file.fieldname == 'orgPic') {
                req.orgPic = name
            }
            else if (file.fieldname == 'orgBackgroundPic') {
                req.orgBackgroundPic = name
            }
            fun(null, name)
        }
    }),
    limits: fileSize,
    fileFilter: imageFilter
})



const eventImageHandler = multer({
    storage: multer.diskStorage({
        destination: (req, file, fun) => {
            if (file.fieldname == 'eventBackgroundPic') {
                fun(null, 'images/events')
            }
            else if (file.fieldname == 'sig') {
                fun(null, 'public/sigs')
            }
        },
        filename: (req, file, fun) => {
            if (req.body.onlyFields) return   
            
            let name = Date.now() + path.extname(file.originalname)
            if (file.fieldname == 'eventBackgroundPic') {
                req.eventPic = name
            }
            else if (file.fieldname == 'sig') {
                req.sig = name
            }
            fun(null, name)
        }
    }),
    limits: fileSize,
    fileFilter: imageFilter
})


const certFileHandler = multer({
    storage: multer.diskStorage({
        destination: (req, file, fun) => {
            fun(null, 'public/certs')
        },
        filename: (req, file, fun) => {
            let name = Date.now() + path.extname(file.originalname)
            req.cert = name
            fun(null, name)
        }
    }),
    limits: fileSize,
    fileFilter: imageFilter
})


async function sendUserImages(req, res) {

    images = path.join(__dirname, '../images')
    image = req.params.imageName

    //HOST/uploads/users/ImageName
    res.sendFile(`${images}/users/${image}`)
}



async function sendOrgImages(req, res) {

    images = path.join(__dirname, '../images/orgs')
    image = req.params.imageName
    o_bg = (req.params.o_bg).toLowerCase()

    if (o_bg == 'orgimage') {
        //HOST/uploads/orgs/orgImage/ImageName
        res.sendFile(`${images}/org_images/${image}`)
    }
    else if (o_bg == 'backgroundimage') {
        //HOST/uploads/org/backgroundImage/ImageName
        res.sendFile(`${images}/background_images/${image}`)
    }
    else {
        res.send("Hmm Something Is Not Right?")
    }
}


async function sendEventImages(req, res) {

    images = path.join(__dirname, '../images/events')
    image = req.params.imageName
    e_s = (req.params.e_s).toLowerCase()

    if (e_s == '') {
        //HOST/uploads/event/ImageName
        res.sendFile(`${images}/${image}`)
    }
    else if (e_s == 'sig') {
        //HOST/uploads/events/sig/ImageName
        res.sendFile(`${images}/sigs/${image}`)
    }
    else {
        res.send("Hmm Something Is Not Right?")
    }
}

function handleEventImages(req,res,next) {
    eventImageHandler.fields([
        { name: 'eventBackgroundPic' },
        { name: 'sig' },
    ])(req,res)
    next()
}

module.exports = {
    orgImageHandler,
    userImageHandler,
    eventImageHandler,
    certFileHandler,
    handleEventImages
}