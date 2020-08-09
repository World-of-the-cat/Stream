const shell = require('shelljs');

shell.exec('./stream.sh', (code, stdout, stderr) => {
    /*console.log('Exit code:', code);
    console.log('Program output:', stdout);
    console.log('Program stderr:', stderr);*/
    startStream();
});

function startStream() {
    shell.exec('./stream.sh', (code, stdout, stderr) => {
        /*console.log('Exit code:', code);
        console.log('Program output:', stdout);
        console.log('Program stderr:', stderr);*/
        startStream();
    });
}